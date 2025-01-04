{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) system;
  def = {
    default = false;
  };
  null = {
    default = null;
  };
  setFmt = pkgs.formats.ini { };
in
with lib;
with lib.types;
{
  # ylib & stylix
  umport = inputs.nypkgs.legacyPackages.${system}.lib.umport;
  imports = {
    exclude = [ ./default.nix ];
    path = ./.;
  };
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
}
