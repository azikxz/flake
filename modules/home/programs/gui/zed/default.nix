{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.zed;
in
{
  options = {
    module.programs.gui.zed = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.zed-editor = True // {
      extensions = [
        "nix"
        "city-lights"
      ];
      userSettings = {
        features = {
          copilot = false;
        };
        telemetry = {
          metrics = false;
        };
        vim_mode = true;
        ui_font_size = 16;
        buffer_font_size = 16;
      };
    };
  };
}
