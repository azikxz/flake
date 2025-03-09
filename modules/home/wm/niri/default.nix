{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.niri;
in

{
  options = {
    module.wm.niri = {
      enable = mkBool false;
    };
  };

  imports = with inputs; [ niri.homeModules.niri ];
  config = mkIf cfg.enable {
    programs.niri = on // {
      package = pkgs.niri-unstable;
      settings =
        {
          binds = import ./binds.nix {
            inherit
              config
              ;
          };
        }
        // import ./settings.nix {
          inherit
            lib
            config
            ;
        };
    };
  };
}
