{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  programs.hyprland.enable = true;

  hm.wayland.windowManager.hyprland = {
    enable = if config.programs.hyprland.enable then true else false;

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
