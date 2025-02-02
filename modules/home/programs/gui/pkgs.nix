{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui;
in
{
  options = {
    module.programs.gui = {
      pkgs = mkList.pkgs [ ];
    };
  };

  config = {
    home.packages = [ ] ++ cfg.pkgs;
  };
}
