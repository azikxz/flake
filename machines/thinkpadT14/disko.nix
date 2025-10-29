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
          size = "412G";

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
        options = [ "x-gvfs-show" ];
      };
    in

    {
      fileSystems = {
        "/media/disks/mark2" = ext4 // {
          device = mk "add0974f-e762-457c-96fb-2050609a0288";
        };
      };
    }
  )
