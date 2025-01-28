{ inputs, lib, ... }:
{
  flake = import ../../libx/builder.nix {
    inherit inputs lib;
    flakeDir = "/persist/flake";
    pass = "/persist/vault/pass.kdbx";
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
