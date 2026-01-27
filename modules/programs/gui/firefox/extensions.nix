{
  pkgs,
  lib,
  config,
  ...
}:

lib.attrValues (
  {
    # https://nur.nix-community.org/repos/rycee
    # inherit (pkgs.nur.repos.rycee.firefox-addons) ;
    # # own packages supermacy

    # from ../../../../packages/firefox-addons/package.nix
    inherit (pkgs.firefox-addons.packages)
      darkreader
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
  // (lib.optionalAttrs config.hm.programs.keepassxc.enable {
    inherit (pkgs.firefox-addons.packages)
      keepassxc-browser
      ;
  })
  // (lib.optionalAttrs config.hm.programs.rbw.enable {
    inherit (pkgs.firefox-addons.packages)
      bitwarden-password-manager
      ;
  })
)
