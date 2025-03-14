{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.games;
in

{
  options = {
    module.groups.games = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.games = mkGroup [
      "mindustry"
      "minecraft"
      "openarena"
      "srb2"
      "wine"
    ];
  };
}
