{ inputs, lib, ... }:
{
  flake = import ../../libx/builder.nix {
    inherit inputs lib;
    # variables
    hostName = "embrace";
    userName = "huggyer";
    flakeDir = "/persist/flake";
    is = "laptop";
    # customize
    theme = "neo-gen";
    image = "town";
    # sys info
    ver = "24.05";
  };
}
