{
  pkgs,
  lib,
  ...
}:

with pkgs.nur.repos.rycee.firefox-addons;
let
  custom = pkgs.callPackage ./addons.nix {
    inherit
      pkgs
      lib
      ;
  };
in

[
  ublock-origin
  sponsorblock
  darkreader
  vimium-c
  censor-tracker
  #
  tabcenter-reborn
  firefox-color
  stylus
  translate-web-pages
]
++ (with custom; [
  torrserver-adder
])
