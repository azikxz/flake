{
  x,
  lib,
  config,
  inputs,
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
      enable = mkBool;
    };
  };

  imports = with inputs; [ stylix.nixosModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      # COLORIZE !!!
      autoEnable = false;
      base16Scheme = "${base16}/${x.theme}.yaml";
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
