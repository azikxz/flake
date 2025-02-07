{ inputs, lib, ... }:
{
  flake = import ../../libx {
    inherit inputs lib;
    flakeDir = "/persist/flake";
    pass = "/persist/vault/passwords.kdbx";
    # variables
    hostName = "jetpure";
    userName = "nixzoid";
    is = "desktop";
    # customize
    theme = "paradise";
    image = "lampa";
    # sys info
    ver = "24.05";
  };
}
