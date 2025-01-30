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
import ./nixpkgs
// {
  stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
  # ylib & stylix
  umport = (import ./umport.nix { inherit lib; }).umport;

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;
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
