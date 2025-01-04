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
    environment.systemPackages = [ ] ++ (cfg.pkgs);
    programs = {
      nano = False;
      light = True;
      git = True // {
        package = mkDefault pkgs.gitMinimal;
      };
      ryzen-monitor-ng = True;
      nh = True // {
        flake = flakeDir;
      };
    };
  };
}
