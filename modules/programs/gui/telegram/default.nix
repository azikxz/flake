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
  persist.user.dirs = [ ".local/share/64Gram/tdata" ];

  hmPackages = [ pkgs._64gram ];

  hm = {
    xdg = {
      mimeApps = import ./mime.nix {
        inherit
          lib
          ;
      };

      dataFile = import ./configs.nix {
        inherit
          config
          ;
      };
    };

    home.activation = mkIf config.stylix.enable {
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

  hmMime = mkMime {
    "io.github.tdesktop_x64.TDesktop.desktop" = [ "x-scheme-handler/tg" ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      _64gram = prev.symlinkJoin {
        name = "telegram-desktop";
        paths = [ prev._64gram ];
        buildInputs = [ prev.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/Telegram \
            --set QT_QPA_PLATFORMTHEME wayland \
            --set XDG_CURRENT_DESKTOP gnome

          cd $out/bin
          ln -s Telegram telegram-desktop
        '';
      };
    })
  ];
}
