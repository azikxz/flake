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
  inherit (inputs) base16;
in
{
  options = {
    module.themes.stylix = {
      enable = mkBool false;
    };
  };

  imports = with inputs; [ stylix.nixosModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      # COLORIZE !!!
      autoEnable = false;
      image = import ./image.nix {
        inherit
          inputs
          pkgs
          lib
          config
          ;
      };
      base16Scheme = "${base16}/${x.styl.theme}.yaml";
      targets = {
        console = on; # TTY
        chromium = on; # TTY
        fish = on; # SHELL
        plymouth = on // {
          logoAnimated = true;
        }; # STARTING SCREEN
      };
    };
  };
}
