{
  inputs,
  lib,
  ...
}:
let
  def = {
    default = false;
  };
  null = {
    default = null;
  };
in
with lib;
with lib.types;
{
  stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
  # ylib & stylix
  umport = (import ./umport.nix { inherit lib; }).umport;

  # enable = true; ++ enable = false;
  True = {
    enable = true;
  };
  False = {
    enable = false;
  };
  # mkOption and mkEnableOption
  mkEnable = mkEnableOption "";
  mkBool = mkOption def // {
    type = bool;
  };
  mkOpt = {
    str = mkOption def // {
      type = str;
    };
    lines = mkOption null // {
      type = nullOr lines;
    };
    list = {
      pkgs = mkOption null // {
        type = listOf package;
      };
      str = mkOption null // {
        type = listOf str;
      };
    };
    attrs = {
      str = mkOption null // {
        type = attrsOf str;
      };
    };
  };
  mkConfig = {
    ini = mkOption {
      type = submodule { freeformType = settingsFormat.type; };
      default = { };
    };
  };

  # nix subsitutters and keys
  substituters = [
    "https://nix-gaming.cachix.org" # NIX GAMING
    "https://hyprland.cachix.org" # HYPRLAND
    "https://cache.garnix.io" # AYUGRAM
    "https://helix.cachix.org" # HELIX
  ];
  keys = [
    "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" # NIX GAMING
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # HYPRLAND
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" # AYUGRAM
    "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" # HELIX
  ];

  overlays = with inputs; [
    nixpkgs-wayland.overlay
  ];

  gen = type: text: lib.generators.${type} { } text;
}
