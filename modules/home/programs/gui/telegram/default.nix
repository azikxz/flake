{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.telegram;
in

{
  options = {
    module.programs.gui.telegram = {
      enable = mkBool false;
      package = mkPkg pkgs.stable._64gram;
      walogram.mode = mkStr "solid"; # solid | background
    };
  };

  config = mkIf cfg.enable {
    impermanence.dirs = [
      ".local/share/${
        if
          elem cfg.package [
            pkgs._64gram
            pkgs.stable._64gram
          ]
        then
          "64Gram"
        else if cfg.package == pkgs.ayugram-desktop then
          "AyuGramDesktop"
        else
          "TelegramDesktop"
      }/tdata"
      ".cache/stylix-telegram-theme"
    ];
    home.packages =
      [ cfg.package ]
      ++ (optional (cfg.package == pkgs.ayugram-desktop) (
        pkgs.writeShellScriptBin "telegram-desktop" ''
          ayugram-desktop
        ''
      ));
    xdg = {
      mimeApps = import ./mime.nix {
        inherit
          pkgs
          lib
          config
          ;
      };
      dataFile = import ./configs.nix {
        inherit
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
      mkIf (cfg.package != null) {
        telegramTheme =
          hm.dag.entryAfter [ "" ]
            # sh
            ("run " + getExe walogram);
      };
  };
}
