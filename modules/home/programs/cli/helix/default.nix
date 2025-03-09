{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.helix;
in

{
  options = {
    module.programs.cli.helix = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.helix = on // {
      defaultEditor = true;
      settings = import ./settings.nix // {
        keys = import ./binds.nix;
      };
      languages = import ./languages.nix {
        inherit
          pkgs
          lib
          ;
      };
      themes = import ./theme.nix {
        inherit
          lib
          config
          ;
      };
    };
  };
}
