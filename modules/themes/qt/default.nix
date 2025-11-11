{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# stylix have an weird qt
# so i made own

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
