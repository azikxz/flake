{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# idk maybe on 2st place?

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  hm = {
    programs.niri = {
      inherit (config.programs.niri)
        enable
        package
        ;

      settings = {
        binds = import ./binds.nix {
          inherit
            pkgs
            lib
            config
            ;
        };
      }
      // import ./settings.nix {
        inherit
          pkgs
          lib
          config
          ;
      };
    };

    xdg.portal = {
      config.niri = {
        default = [
          "gtk"
          "gnome"
        ];
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    systemd.user.services.stylix-bg-niri = {
      Unit = {
        Description = "Sets stylix image as background for niri";
        After = [ "niri.service" ];
      };

      Service = {
        ExecStart = concatStringsSep " " [
          (lib.getExe pkgs.swaybg)
          "--image"
          config.stylix.image
        ];

        Type = "simple";
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
