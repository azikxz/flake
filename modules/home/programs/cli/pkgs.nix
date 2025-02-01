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
  cfg = config.module.programs.cli;
in
{
  options = {
    module.programs.cli = {
      pkgs = mkOpt.list.pkgs;
    };
  };

  config = {
    home.packages =
      with pkgs;
      [
        nurl
        trashy
        nix-tree
      ]
      ++ cfg.pkgs;
  };
}
