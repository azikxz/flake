{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.winapps;
in
{
  options = {
    module.programs.winapps = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with inputs; [
      winapps.packages.${pkgs.system}.winapps
      winapps.packages.${pkgs.system}.winapps-launcher
    ];
  };
}
