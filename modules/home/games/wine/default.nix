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
      bottles
    ];
    xdg.dataFile = mkIf (sys.is == "desktop") {
      "bottles/data.yml".text = toGen "toYAML" {
        custom_bottles_path = "/mnt/HDD/Bottles";
      };
    };
  };
}
