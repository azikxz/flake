{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.nix-index;
in

{
  options = {
    module.shells.nix-index = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.nix-index = on // {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
