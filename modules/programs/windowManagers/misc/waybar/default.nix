{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

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
