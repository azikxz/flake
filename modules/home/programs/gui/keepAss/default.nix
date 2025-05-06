{
  pkgs,
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
      enable = mkBool (if lib.x.path.pass != null then true else false);
      gnome.enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf cfg.gnome.enable [
      pkgs.gnome-gnome-secrets
    ];
    programs.keepassxc = on // {
      settings = import ./settings.nix {
        inherit
          lib
          ;
      };
    };
  };
}
