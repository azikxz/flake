{
  pkgs,
  lib,
  ...
}:

lib.attrValues {
  inherit (pkgs.nur.repos.rycee.firefox-addons)
    censor-tracker
    darkreader
    keepassxc-browser
    sponsorblock
    stylus
    translate-web-pages
    ublock-origin
    ;

  inherit (pkgs.firefox-addons)
    torrserver-adder
    ;
}
