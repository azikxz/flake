{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = on // {
      package = pkgs.ungoogled-chromium;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      ];
    };
  };
}
