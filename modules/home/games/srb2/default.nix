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
    };
  };

  config = mkIf cfg.enable {
    impermanence.dirs = [ ".srb2" ];
    home.packages = with pkgs; [
      srb2
    ];
  };
}
