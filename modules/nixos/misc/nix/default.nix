{
  pkgs,
  lib,
  ...
}:

with lib;
with x;
let
  inherit (lib.x.nix) subs keys over;
  inherit (pkgs) nix hydra-check;
in

{
  environment.systemPackages = [ hydra-check ];
  nix = {
    package = nix;
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        sys.userName
        "@wheel"
      ];
      substituters = subs;
      trusted-public-keys = keys;
    };
  };
  nixpkgs = {
    hostPlatform = mkDefault sys.platform;
    overlays = over;
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
  system.stateVersion = sys.ver;
}
