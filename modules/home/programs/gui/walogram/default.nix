{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.walogram;
in
{
  options = {
    module.programs.gui.walogram = {
      enable = mkBool;
      mode = mkOpt.str; # solid | background
    };
  };

  config = mkIf cfg.enable {
    home.activation =
      let
        walogram = import ./walogram.nix { inherit pkgs config; };
      in
      {
        telegramTheme = hm.dag.entryAfter [ "" ] ''
          run ${getExe walogram}
        '';
      };
  };
}
