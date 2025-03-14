{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.imageEdit;
in

{
  options = {
    module.programs.cli.imageEdit = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick
      jpegoptim
      optipng
      lutgen
    ];
  };
}
