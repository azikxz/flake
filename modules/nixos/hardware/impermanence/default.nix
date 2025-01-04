{
  x,
  inputs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.impermanence;
in
{
  options = {
    module.hardware.impermanence = {
      enable = mkBool;
    };
  };

  imports = with inputs; [ impermanence.nixosModules.impermanence ];
  config = mkIf cfg.enable {
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@crypted.service" ];
      before = [ "sysroot.mount" ];
      script = ''
        mkdir -p /btrfs_tmp
        mount ${disk} /btrfs_tmp
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
