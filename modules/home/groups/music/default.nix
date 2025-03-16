{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.music;
in

{
  options = {
    module.groups.music = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module = {
      programs.gui = mkGrpOn [
        "spotify"
      ];
    };
  };
}
