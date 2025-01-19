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
  cfg = config.module.wm.sway;
in
{
  options = {
    module.wm.sway = {
      enable = mkBool;
      programs = mkOpt.attrs.str;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = on // {
      package = pkgs.swayfx;
      checkConfig = false;
      xwayland = true;
      systemd = on;
    };
  };
}
