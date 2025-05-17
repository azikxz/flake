{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.themes.stylix;
in

{
  options = {
    module.themes.stylix = {
      enable = mkBool false;
      icon = mkNull.str null;
    };
  };

  imports = with inputs; [ niri.homeModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      autoEnable = false;
      iconTheme = on // {
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme.override {
          color = cfg.icon;
        };
      };
      targets = import ./targets.nix {
        inherit
          lib
          ;
      };
    };
  };
}
