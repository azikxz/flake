{ inputs, lib, ... }:
{
  flake = import ../../libx/builder.nix {
    inherit inputs lib;
    pass = "/persist/vault/pass.kdbx";
    # variables
    hostName = "jetpure";
    userName = "nixzoid";
    flakeDir = "/persist/flake";
    is = "desktop";
    # customize
    theme = "tarot";
    image = "clouds";
    # sys info
    ver = "24.05";
    # ++ devices
    dev = {
      hdd = "/mnt/HDD";
      ssd = "/mnt/SSD";
    };
  };
}
