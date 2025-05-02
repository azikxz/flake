{
  inputs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.impermanence;
in

{
  options = {
    module.misc.impermanence = {
      enable = mkBool false;
    };
    impermanence = with types; {
      dirs = mkList.str [ ];
      files = mkList.str [ ];
    };
  };

  imports = with inputs; [ impermanence.homeManagerModules.impermanence ];
  config = mkIf cfg.enable {
    home.persistence.${x.path.impermanence + "/home"} = with config.impermanence; {
      directories = [
        ".ssh"
      ] ++ dirs;
      files = [ ] ++ files;
    };
  };
}
