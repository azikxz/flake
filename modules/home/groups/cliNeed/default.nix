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
      programs.cli = mkGroup [
        "common"
        "fetch"
        "helix"
        "yazi"
      ];
      shells = mkGroup [
        "fish"
        "starship"
        "translate"
      ];
    };
  };
}
