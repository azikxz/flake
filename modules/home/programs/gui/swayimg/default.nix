{
  lib,
  config,
  ...
}:

with lib;
with x;

let
  cfg = config.module.programs.gui.swayimg;
  font = config.stylix.fonts;
in
{
  options = {
    module.programs.gui.swayimg = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.swayimg = on // {
      settings = import ./settings.nix {
        inherit
          config
          ;
      };
    };
  };
}
