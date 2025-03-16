{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.social;
in

{
  options = {
    module.groups.social = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.gui = mkGrpOn [
      "nixcord"
      "telegram"
    ];
  };
}
