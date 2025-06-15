{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  package = pkgs._64gram;
in

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/${
      if
        elem package [
          pkgs._64gram
          pkgs._24._64gram
          pkgs._25._64gram
        ]
      then
        "64Gram"
      else if package == pkgs.ayugram-desktop then
        "AyuGramDesktop"
      else
        "TelegramDesktop"
    }/tdata"
  ];

  environment.systemPackages =
    [ package ]
    ++ (optional (package == pkgs.ayugram-desktop) (
      pkgs.writeShellScriptBin "telegram-desktop" ''
        ayugram-desktop
      ''
    ));

  hm = {
    xdg = {
      mimeApps = import ./mime.nix {
        inherit
          package
          pkgs
          lib
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
