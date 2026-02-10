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
      mk =
        {
          name ? throw "set label pls",
          opt ? [ ],
        }:
        {
          device = "/dev/disk/by-label/${name}";
          fsType = "ext4";
          options = [
            "x-gvfs-show"
          ]
          ++ opt;
        };
    in

    {
      fileSystems = builtins.listToAttrs (
        map
          (name: {
            name = "/media/${name}";
            value = mk {
              inherit
                name
                ;
            };
          })
          [
            "fatKartman"
            "fastRider"
          ]
      );
    }
  )
