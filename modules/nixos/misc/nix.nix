{
  x,
  pkgs,
  lib,
  ...
}:
with lib;
with x;
{
  nix = {
    package = pkgs.nix;
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
      substituters = [
        "https://hyprland.cachix.org" # HYPRLAND
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # HYPRLAND
      ];
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
  system.stateVersion = ver;
}
