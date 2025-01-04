{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.zoxide;
in
{
  options = {
    module.programs.cli.zoxide = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = True // {
      enableFishIntegration = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
