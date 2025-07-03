{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14" || machine == "pcRyazenka") {
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
        lib
        config
        ;
    };
  };
}
