{
  inputs,
  device,
  ...
}:

{
  imports = with inputs; [ disko.nixosModules.default ];
  disko.devices.disk.main = {
    inherit device;
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "esp";
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "umask=0077"
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };
        root = {
          name = "nixos";
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/rootfs".mountpoint = "/";
              "/home" = {
                mountpoint = "/home";
                mountOptions = [ "compress=zstd:5" ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "compress=zstd:5"
                  "noatime"
                ];
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [
                  "compress=zstd:5"
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
