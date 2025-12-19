{
  device,
  ...
}:

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
          size = "180G";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };

        # other 60G will be for windows
      };
    };
  };
}

//

  (
    let
      mk =
        {
          device,
        }:
        {
          inherit
            device
            ;

          fsType = "ext4";
          options = [ "x-gvfs-show" ];
        };
    in

    {
      fileSystems = {
        "/media/disks/samsaDisker" = mk {
          device = "/dev/disk/by-label/samsaDisker";
        };
      };
    }
  )
