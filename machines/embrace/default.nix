{ inputs, lib, ... }:
{
  flake = import ../../libx/builder.nix {
    inherit inputs lib;
    # variables
    hostName = "embrace";
    userName = "wurkote";
    is = "desktop";
    # customize
    theme = "paradise";
    image = "rocks";
    # sys info
    ver = "24.05";
  };
}
