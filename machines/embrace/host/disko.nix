{
  device ? throw,
  ...
}:
{
  disko.devices.disk.main = {
    inherit device;
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "EFI";
          size = "500M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "defaults"
              "umask=0077"
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };
        root = {
          name = "NIXOS";
          size = "90%";
          content = {
            type = "lvm_pv";
            vg = "pool";
          };
        };
      };
    };
  };
  lvm_vg = {
    pool = {
      type = "lvm_vg";
      lvs = {
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root".mountpoint = "/";
              "/home" = {
                mountpoint = "/home";
                mountOptions = [
                  "compress=zstd:5"
                  "subvol=home"
                ];
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [
                  "compress=zstd:5"
                  "subvol=persist"
                  "noatime"
                ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd:5"
                  "subvol=nix"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}
