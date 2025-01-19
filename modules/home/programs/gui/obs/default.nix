{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.obs;
in
{
  options = {
    module.programs.gui.obs = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.obs-studio = on // {
      package = pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        input-overlay
      ];
    };
  };
}
