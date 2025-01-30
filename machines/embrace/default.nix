{ inputs, lib, ... }:
{
  flake = import ../libx {
    inherit inputs lib;
    flakeDir = "/persist/flake";
    # variables
    hostName = "embrace";
    userName = "huggyer";
    is = "laptop";
    # customize
    theme = "neo-gen";
    image = "town";
    # sys info
    ver = "24.05";
  };
}
