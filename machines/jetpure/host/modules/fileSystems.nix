let
  mk = name: "/dev/disk/by-uuid/" + name;
  ext4 = {
    fsType = "ext4";
    options = [
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };
in

{
  fileSystems = {
    "/media/disks/bigBunny" = ext4 // {
      device = mk "9290bc08-17fe-47db-a535-d4044b8c8dfb";
    };
    "/media/disks/fastBitch" = ext4 // {
      device = mk "e6bc9034-95a4-43bd-b5f5-c7c1743e9f7c";
    };
  };
}
