{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.themes;
in

{
  options = {
    module.groups.themes = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.themes = mkGroup [
      "qt"
      "stylix"
    ];
  };
}
