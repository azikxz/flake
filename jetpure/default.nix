{
  inputs,
  lib,
  ...
}:
{
  flake = import ../libx/builder.nix {
    inherit inputs lib;
    disk = "/dev/disk/by-uuid/d8440438-2f95-4854-b139-bf0a3e91a81f";
    pass = "/persist/vault/pass.kdbx";
    # variables
    hostName = "jetpure";
    userName = "nixzoid";
    flakeDir = "/persist/flake";
    is = "desktop";
    # customize
    theme = "paradise";
    image = "rocks";
    # sys info
    plfrm = "x86_64-linux";
    ver = "24.05";
    # ++ devices
    dev = {
      hdd = "/mnt/HDD";
      ssd = "/mnt/SSD";
    };
  };
}
