{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.games.mindustry;
in

{
  options = {
    module.games.mindustry = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mindustry-wayland
    ];
  };
}
