{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = on // {
      enableFishIntegration = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
