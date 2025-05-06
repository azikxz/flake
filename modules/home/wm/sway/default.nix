{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.sway;
in

{
  options = {
    module.wm.sway = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = on // {
      package = pkgs.swayfx;
      config = import ./settings/main.nix {
        inherit
          pkgs
          lib
          config
          ;
      };
      extraConfig = import ./settings/extra.nix {
        inherit
          config
          ;
      };
      checkConfig = false;
      xwayland = true;
      systemd = on;
      swaynag = on // {
        settings = import ./swaynag.nix {
          inherit
            config
            ;
        };
      };
    };
  };
}
