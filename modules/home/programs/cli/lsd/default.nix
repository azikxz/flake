{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.lsd;
in

{
  options = {
    module.programs.cli.lsd = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.lsd = on // {
      enableAliases = true;
      settings = {
        header = false;
        color = {
          when = "auto";
        };
        icons = {
          when = "always";
          ignore-globs = [ ".git" ];
        };
      };
    };
  };
}
