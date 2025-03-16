{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.systop;
in

{
  options = {
    module.programs.cli.systop = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.cli = mkGrpOn [
      "btop"
      "nvtop"
    ];
  };
}
