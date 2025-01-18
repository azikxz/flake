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
  cfg = config.module.programs.gui.chromium;
in
{
  options = {
    module.programs.gui.chromium = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = True // {
      package = pkgs.ungoogled-chromium;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      ];
    };
  };
}
