{
  device ? throw,
  ...
}:

let
  compress = "compress=zstd:8";
in

{
  disko.devices.disk.disko = {
    inherit device;
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "defaults"
              "umask=0077"
            ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = [
                  compress
                ];
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [
                  compress
                ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  compress
                  "noatime"
                  "noacl"
                ];
              };
            };
          };
        };
      };
    };
  };
}
