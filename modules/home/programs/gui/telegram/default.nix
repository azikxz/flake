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
      package = mkPkg pkgs.ayugram-desktop;
      walogram.mode = mkStr "solid"; # solid | background
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.dataFile = import ./configs.nix {
      inherit
        pkgs
        lib
        config
        ;
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
          hm.dag.entryAfter
            [
              ""
            ]
            # sh
            ''
              run ${getExe walogram}
            '';
      };
  };
}
