{ pkgs }:

pkgs.writeScriptBin "qbh" (import ./qbhelper.nix)
