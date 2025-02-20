{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.hardware.impermanence;
  dev =
    if x.sys.is == "laptop" then
      "/dev/pool/root"
    else if x.sys.is == "desktop" then
      "/dev/pool/root"
    else
      null;
in

{
  options = {
    module.hardware.impermanence = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    fileSystems."/persist".neededForBoot = true;
    boot.initrd = {
      systemd.enable = false;
      postDeviceCommands =
        lib.mkAfter
          #sh
          ''
            mkdir /btrfs_tmp
            mount /dev/disk/by-partlabel/disk-disko-root /btrfs_tmp
            if [[ -e /btrfs_tmp/root ]]; then
                mkdir -p /btrfs_tmp/old_roots
                timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
                mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            delete_subvolume_recursively() {
                IFS=$'\n'
                for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                    delete_subvolume_recursively "/btrfs_tmp/$i"
                done
                btrfs subvolume delete "$1"
            }

            for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                delete_subvolume_recursively "$i"
            done

            btrfs subvolume create /btrfs_tmp/root
            umount /btrfs_tmp
          '';
    };
  };
}
