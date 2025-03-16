{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.cliNeed;
in

{
  options = {
    module.groups.cliNeed = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module = {
      programs.cli = mkGrpOn [
        "common"
        "fetch"
        "helix"
        "yazi"
      ];
      shells = mkGrpOn [
        "fish"
        "starship"
        "translate"
      ];
    };
  };
}
