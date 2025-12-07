{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# best messaging
# now with stylix theming

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/AyuGramDesktop/tdata" ];

  hmPackages = [ pkgs.ayugram-desktop ];

  hm = {
    xdg = {
      mimeApps = {
        defaultApplications = (t: l: (genAttrs l (n: t))) "com.ayugram.desktop.desktop" [
          "application/x-xdg-protocol-tg"
          "x-scheme-handler/tg"
        ];
      };

      dataFile = import ./configs.nix {
        inherit
          config
          ;
      };
    };

    systemd.user.services.telegram-tray = {
      Unit = {
        Description = pkgs.ayugram-desktop.meta.description;
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = concatStringsSep " " [
          (getExe pkgs.ayugram-desktop)
          "-startintray"
        ];

        Type = "simple";
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };

    home.activation = mkIf config.hm.stylix.enable {
      telegramTheme = hm.dag.entryAfter [ "" ] (
        "run "
        + getExe (
          import ./walogram.nix {
            inherit
              pkgs
              config
              ;
          }
        )
      );
    };
  };
}
