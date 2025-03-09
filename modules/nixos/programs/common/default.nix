{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.common;
in

{
  options = {
    module.programs.common = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      killall
      helix
      fff
    ];
    programs = {
      adb = if sys.is == "laptop " then on else off;
      light = if sys.is == "desktop" then on else off;
      git.package = mkDefault pkgs.gitMinimal;
    };
  };
}
