{
  pkgs,
  lib,
  ...
}:

lib.attrValues {
  # https://nur.nix-community.org/repos/rycee
  # inherit (pkgs.nur.repos.rycee.firefox-addons) ;
  # # own packages supermacy

  # from ../../../../packages/firefox-addons/package.nix
  inherit (pkgs.firefox-addons.packages)
    bitwarden-password-manager
    darkreader
    keepassxc-browser
    libredirect
    protondb-for-steam
    redirectnixwiki
    sponsorblock
    steam-database
    styl-us
    torrserver-adder
    traduzir-paginas-web
    ublock-origin
    youtube-addon
    ;
}
