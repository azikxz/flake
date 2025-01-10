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
  cfg = config.module.programs.custom.notify-send;
in
{
  options = {
    module.programs.custom.notify-send = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (callPackage ./package.nix { })
    ];
  };
}
