{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.archivers;
in

{
  options = {
    module.programs.cli.archivers = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zip
      unzip
      unrar
      p7zip-rar
    ];
  };
}
