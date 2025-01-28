{
  inputs,
  lib,
  ...
}:
let
  def = {
    default = false;
  };
  nulla = {
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
  on = {
    enable = true;
  };
  off = {
    enable = false;
  };
  # mkOption and mkEnableOption
  mkEnable = mkEnableOption "";
  mkBool = mkOption def // {
    type = bool;
  };
  mkOpt = {
    str = mkOption nulla // {
      type = str;
    };
    int = mkOption nulla // {
      type = int;
    };
    lines = mkOption nulla // {
      type = nullOr lines;
    };
    list = {
      pkgs = mkOption nulla // {
        type = listOf package;
      };
      str = mkOption nulla // {
        type = listOf str;
      };
    };
    attrs = {
      str = mkOption nulla // {
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

  # overlays, nix subsitutters and keys
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
  overlays = [
    (self: super: {
      steam-run =
        (super.steam.override {
          extraLibraries =
            pkgs: with pkgs; [
              libxkbcommon
              mesa
              wayland
              (sndio.overrideAttrs (old: {
                postFixup =
                  old.postFixup
                  + ''
                    ln -s $out/lib/libsndio.so $out/lib/libsndio.so.6.1
                  '';
              }))
            ];
        }).run;
    })
  ];

  gen = type: text: lib.generators.${type} { } text;

  workspaces =
    with builtins;
    (concatLists (
      genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 10
    ));
}
