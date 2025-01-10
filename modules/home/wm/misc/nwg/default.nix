{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.misc.nwg;
in
{
  options = {
    module.wm.misc.nwg = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = with config.lib.stylix.colors.withHashtag; {
      "nwg-drawer/drawer.css".text = # cs
        ''
          window {
            color = ${base06};
            background-color: ${base00};
          }
          button {
            color: ${base04};
            background-color: ${base00};
          }
          button:hover {
            color: ${base04};
            background-color: ${base01};
          }
        '';
    };
  };
}
