{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.games.srb2;
in

{
  options = {
    module.games.srb2 = {
      enable = mkBool false;
      kart.enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        srb2
      ]
      ++ optional cfg.kart.enable [
        srb2kart
      ];
  };
}
