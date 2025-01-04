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
  cfg = config.module.programs.custom.anicli;
in
{
  options = {
    module.programs.custom.anicli = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ (callPackage ./anicli-ru.nix { }) ];
  };
}
