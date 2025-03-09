{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.nvtop;
in

{
  options = {
    module.programs.cli.nvtop = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nvtopPackages.amd ];
  };
}
