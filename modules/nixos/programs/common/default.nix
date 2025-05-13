{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs;
in

{
  options = {
    module.programs = {
      common.enable = mkBool false;
      extraPackages = mkList.pkgs [ ];
    };
  };

  config = mkIf cfg.common.enable {
    environment.systemPackages =
      with pkgs;
      [
        uutils-coreutils-noprefix
        killall
        helix
        fff
      ]
      ++ cfg.extraPackages;
    programs = {
      adb = if (sys.is == "laptop") then on else off;
      light = if (sys.is == "desktop") then on else off;
      git.package = mkDefault pkgs.gitMinimal;
    };
  };
}
