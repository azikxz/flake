{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.rustmission;
in

{
  options = {
    module.programs.cli.rustmission = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rustmission ];
    xdg.configFile = {
      "rustmission/config.toml".source = ./config.toml;
    };
  };
}
