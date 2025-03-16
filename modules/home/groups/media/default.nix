{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.media;
in

{
  options = {
    module.groups.media = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module = {
      programs.gui = mkGrpOn [
        "mpv"
        "swayimg"
        "zathura"
      ];
    };
  };
}
