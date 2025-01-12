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
      nano = False;
      light = if x.is == "iso" then False else True;
      git = True // {
        package = mkDefault pkgs.gitMinimal;
      };
      ryzen-monitor-ng = if x.is == "iso" then False else True;
      nh =
        if x.is == "iso" then
          False
        else
          True
          // {
            flake = flakeDir;
          };
    };
  };
}
