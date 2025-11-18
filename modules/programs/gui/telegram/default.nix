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

  hmPackages = with pkgs; [
    (symlinkJoin {
      name = "ayugram-desktop";

      paths = [ ayugram-desktop ];
      buildInputs = [ makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/AyuGram --set 'XDG_CURRENT_DESKTOP' 'gnome'

        ln -s $out/bin/AyuGram $out/bin/Telegram
        ln -s $out/bin/AyuGram $out/bin/telegram-desktop
      '';
    })
  ];

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
