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
      programs.gui = mkGroup [
        "mpv"
        "swayimg"
        "zathura"
      ];
    };
  };
}
