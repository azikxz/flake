{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.onefetch;
in

{
  options = {
    module.programs.cli.onefetch = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ onefetch ];
  };
}
