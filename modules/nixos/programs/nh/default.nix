{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.nh;
  inherit (x) path machineName;
in

{
  options = {
    module.programs.nh = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment = {
      variables.NH_FLAKE = path.flake;
      shellAliases = {
        goToFlake = "cd " + path.flake;
        rebuild = "nh os switch -H " + machineName;
        nixRepl = "nh os repl -H " + machineName;
      };
    };
    programs.nh = on // {
      flake = path.flake;
      clean = on;
    };
  };
}
