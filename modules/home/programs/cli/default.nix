{
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
      pkgs = mkList.pkgs [ ];
    };
  };

  config = {
    home.packages =
      with pkgs;
      [
        wget
        nurl
        trashy
        nix-tree
      ]
      ++ cfg.pkgs;
  };
}
