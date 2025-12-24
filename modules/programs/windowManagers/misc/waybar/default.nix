{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# by default it hidden
# press 'Win+Shift+Space' for visible

mkIf (mac "thinkpadT14" || mac "pcRyazenka") {
  hm.programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = import ./style.nix {
      inherit
        config
        ;
    };

    settings = import ./settings.nix {
      inherit
        pkgs
        lib
        config
        ;
    };
  };
}
