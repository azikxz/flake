{
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
        "${sys.userName}"
        "@wheel"
      ];
      substituters = x.nix.subs;
      trusted-public-keys = x.nix.keys;
    };
  };
  nixpkgs = {
    hostPlatform = mkDefault sys.platform;
    overlays = x.nix.over;
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
  system.stateVersion = sys.ver;
}
