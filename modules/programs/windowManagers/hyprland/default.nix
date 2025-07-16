{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  programs.hyprland.enable = true;

  hm.wayland.windowManager.hyprland = {
    enable = config.programs.hyprland.enable;

    xwayland = {
      enable = true;
    };

    systemd = {
      enable = true;
      variables = [
        "--all"
      ];
    };

    settings =
      import ./binds/main.nix {
        inherit
          pkgs
          lib
          config
          ;
      }
      // import ./rules/main.nix {
        inherit
          lib
          config
          ;
      }
      // import ./settings.nix {
        inherit
          pkgs
          lib
          config
          ;
      };
  };
}
