{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/64Gram/tdata" ];

  environment.systemPackages = with pkgs; [
    (symlinkJoin {
      name = "telegram-desktop";
      paths = [ _64gram ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/telegram-desktop \
          --set QT_QPA_PLATFORMTHEME wayland \
          --set XDG_CURRENT_DESKTOP gnome
      '';
    })
  ];

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
}
