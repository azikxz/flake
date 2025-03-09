{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.onefetch ];
    programs.git = on // {
      package = pkgs.gitMinimal;
      userName = sys.userName;
      userEmail = "${sys.userName}@${sys.hostName}.org";
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        safe.directory = path.flake;
      };
    };
  };
}
