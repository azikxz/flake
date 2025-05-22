{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf false {
  hm = {
    home.packages = [ pkgs.nwg-drawer ];

    xdg.configFile = with config.lib.stylix.colors.withHashtag; {
      "nwg-drawer/drawer.css".text = # css
        ''
          window { color = ${base06};
                   background-color: ${base00}; }

          button { color: ${base04};
                   background-color: ${base00}; }

          button:hover { color: ${base04};
                         background-color: ${base01}; }
        '';
    };
  };
}
