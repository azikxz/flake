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
