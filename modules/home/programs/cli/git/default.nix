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
  cfg = config.module.programs.cli.git;
  never = "git@git.sr.ht:~neverness";
  interval = 300;
  repo = {
    ultima = "/persist/flake";
    wallpapers = "/persist/wallpapers";
    readme = "/persist/readme";
    niXtended = "/persist/niXtended";
  };
in
{
  options = {
    module.programs.cli.git = {
      enable = mkBool;
      name = mkOpt.str;
      email = mkOpt.str;
    };
  };

  config = mkIf cfg.enable {
    programs.git = True // {
      package = pkgs.gitMinimal;
      userName = sec.git.name;
      userEmail = sec.git.email;
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        safe.directory = flakeDir;
      };
    };
    services.git-sync = False // {
      repositories = {
        "ultima" = {
          inherit interval;
          uri = "${never}/ultima";
          path = repo.ultima;
        };
        "wallpapers" = {
          inherit interval;
          uri = "${never}/wallpapers";
          path = repo.wallpapers;
        };
        "readme" = {
          inherit interval;
          uri = "${never}/readme";
          path = repo.readme;
        };
        "niXtended" = {
          inherit interval;
          uri = "${never}/niXtended";
          path = repo.niXtended;
        };
      };
    };
  };
}
