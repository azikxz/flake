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
      pkgs = mkOpt.list.pkgs;
    };
  };

  config = {
    home.packages = [ ] ++ cfg.pkgs;
  };
}
