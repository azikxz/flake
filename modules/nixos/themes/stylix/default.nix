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
    };
  };

  imports = with inputs; [ stylix.nixosModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      # colorize !!!
      autoEnable = false;
      image = import ./image.nix {
        inherit
          inputs
          pkgs
          lib
          config
          ;
      };
      base16Scheme = inputs.base16."${x.styl.theme}";
      targets = {
        console = on; # tty
        chromium = on; # tty
        fish = on; # shell
        plymouth = on // {
          logoAnimated = true;
        }; # starting screen
      };
    };
  };
}
