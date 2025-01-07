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
      userName = userName;
      userEmail = "${userName}@nixos.org";
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        safe.directory = flakeDir;
      };
    };
  };
}
