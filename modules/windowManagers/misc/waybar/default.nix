{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
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
        config
        ;
    };
  };
}
