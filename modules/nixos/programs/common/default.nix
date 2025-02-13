{
  x,
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
      helix
      killall
    ];
    programs = {
      adb = on;
      nano = off;
      fuse.userAllowOther = true;
      light = if x.sys.is == "laptop" then on else off;
      git = on // {
        package = mkDefault pkgs.gitMinimal;
      };
      ryzen-monitor-ng = if x.sys.is == "desktop" then on else off;
      nh = on // {
        flake = path.flakeDir;
      };
    };
  };
}
