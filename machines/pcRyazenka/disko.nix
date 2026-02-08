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
          size = "100%";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}

//

  (
    let
      mk = name: "/dev/disk/by-uuid/" + name;

      ext4 = {
        fsType = "ext4";
        options = [
          "user"
          "x-gvfs-show"
        ];
      };
    in

    {
      fileSystems = {
        "/media/disks/fatBunny" = ext4 // {
          device = mk "c39db01d-8014-4b5a-a85e-1a8a4bb697fa";
        };

        "/media/disks/fastBitch" = ext4 // {
          device = mk "cbf20134-a653-493c-96de-b2b6699d16d5";
        };
      };
    }
  )
