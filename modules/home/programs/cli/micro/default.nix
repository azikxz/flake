{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.micro;
in
{
  options = {
    module.programs.cli.micro = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.micro = on // {
      settings = {
        clipboard = "terminal";
        autosu = true;
        mkparents = true;
        scrollbar = true;
        softwrap = true;
        status = false;
        statusline = false;
        statusformatl = "q";
        savehistory = true;
        saveundo = true;
      };
    };
  };
}
