{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.games.wine;
in

{
  options = {
    module.games.wine = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wineWow64Packages.stagingFull
    ];
  };
}
