{
  x,
  pkgs,
  lib,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) nix libnotify;
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
    hostPlatform = mkDefault plfrm;
    config = {
      # NIXPKGS SETS
      allowBroken = true;
      allowUnfree = true;
    };
  };
  system = {
    stateVersion = ver;
    # userActivationScripts = {
    #   rebuildFinished = {
    #     text = ''
    #       ${libnotify}/bin/notify-send "NixOS     rebuild finished" -t 1500"
    #     '';
    #   };
    # };
  };
}
