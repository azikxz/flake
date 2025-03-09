{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.nix-index;
in

{
  options = {
    module.programs.nix-index = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      command-not-found = off;
      nix-index = {
        enableZshIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
    };
  };
}
