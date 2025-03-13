{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.zen-browser;
in

{
  options = {
    module.programs.gui.zen-browser = {
      enable = mkBool false;
      compact.enable = mkBool false;
    };
  };

  imports = [ ./module.nix ];
  config = mkIf cfg.enable {
    programs.zen-browser = on // {
      policies = import ./policies.nix;
      profiles.${x.sys.userName} = {
        settings = (import ./settings.nix).profile;
        extensions = {
          force = true;
          packages = import ./extensions.nix {
            inherit
              pkgs
              lib
              ;
          };
          settings = (import ./settings.nix).ext;
        };
      };
    };
  };
}
