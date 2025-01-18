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
      enable = mkBool;
      pkgs = mkOpt.list.pkgs;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ ] ++ cfg.pkgs;
    programs = {
      fuse.userAllowOther = true;
      nano = False;
      light = if x.is == "laptop" then True else False;
      git = True // {
        package = mkDefault pkgs.gitMinimal;
      };
      ryzen-monitor-ng = if x.is == "desktop" then True else False;
      nh = True // {
        flake = flakeDir;
      };
    };
  };
}
