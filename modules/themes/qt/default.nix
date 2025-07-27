{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac' "isoXtended") {
  hm = {
    qt = {
      enable = true;

      platformTheme.name = "qtct";
    };

    xdg.configFile = import ./qtct.nix {
      inherit
        pkgs
        config
        ;
    };
  };
}
