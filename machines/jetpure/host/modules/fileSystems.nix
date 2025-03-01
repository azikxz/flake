let
  def = {
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
    "/mnt/HDD" = def // {
      device = "/dev/disk/by-uuid/9290bc08-17fe-47db-a535-d4044b8c8dfb";
    };
    "/mnt/SSD" = def // {
      device = "/dev/disk/by-uuid/e6bc9034-95a4-43bd-b5f5-c7c1743e9f7c";
    };
  };
}
