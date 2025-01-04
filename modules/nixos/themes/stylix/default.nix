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
  wal = inputs.design;
in
{
  options = {
    module.themes.stylix = {
      enable = mkBool;
    };
  };

  imports = with inputs; [ stylix.nixosModules.stylix ];
  config = mkIf cfg.enable {
    stylix = True // {
      # COLORIZE !!!
      autoEnable = false;
      base16Scheme = "${wal}/base16/${x.theme}.yaml";
      targets = {
        console = True; # TTY
        chromium = True; # CHROMIUM LOL
        fish = True; # SHELL
        plymouth = True // {
          logoAnimated = true;
        }; # STARTING SCREEN
      };
    };
  };
}
