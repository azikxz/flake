{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.keepass;
in

{
  options = {
    module.programs.gui.keepass = {
      enable = mkBool false;
      gnome = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.keepassxc = on // {
      settings = import ./settings.nix {
        inherit
          lib
          ;
      };
    };
  };
}
