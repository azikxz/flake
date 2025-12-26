{
  pkgs,
  lib,
  ...
}:

lib.attrValues {
  inherit (pkgs.nur.repos.rycee.firefox-addons)
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
