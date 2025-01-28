{
  x,
  pkgs,
  lib,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) nix;
in
{
  nix = {
    package = nix;
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "${userName}"
        "@wheel"
      ];
      substituters = x.substituters;
      trusted-public-keys = x.keys;
    };
  };
  nixpkgs = {
    overlays = x.overlays;
    hostPlatform = mkDefault plfrm;
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
  system.stateVersion = ver;
}
