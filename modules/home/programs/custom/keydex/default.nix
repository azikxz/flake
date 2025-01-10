{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.custom.keydex;
in
{
  options = {
    module.programs.custom.keydex = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (callPackage ./package.nix {
        ver = "0.4.0";
      })
    ];
  };
}
