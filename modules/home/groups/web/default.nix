{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.web;
in

{
  options = {
    module.groups.web = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.gui = mkGroup [
      "qutebrowser"
      "syncthing"
    ];
  };
}
