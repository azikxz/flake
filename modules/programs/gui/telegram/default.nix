{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  package = pkgs.ayugram-desktop;
in

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/${
      if
        elem package [
          pkgs._64gram
          pkgs.stable._64gram
        ]
      then
        "64Gram"
      else if package == pkgs.ayugram-desktop then
        "AyuGramDesktop"
      else
        "TelegramDesktop"
    }/tdata"

    ".cache/stylix-telegram-theme"
  ];

  hm = {
    home.packages =
      [ package ]
      ++ (optional (package == pkgs.ayugram-desktop) (
        pkgs.writeShellScriptBin "telegram-desktop" ''
          ayugram-desktop
        ''
      ));

    xdg = {
      mimeApps = import ./mime.nix {
        inherit
          package
          pkgs
          lib
          config
          ;
      };

      dataFile = import ./configs.nix {
        inherit
          package
          pkgs
          lib
          config
          ;
      };
    };

    home.activation =
      let
        walogram = import ./walogram.nix {
          inherit
            pkgs
            config
            ;
        };
      in
      mkIf (package != null && config.stylix.enable) {
        telegramTheme = hm.dag.entryAfter [ "" ] ("run " + getExe walogram);
      };
  };
}
