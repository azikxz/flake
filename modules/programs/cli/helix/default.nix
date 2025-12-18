{
  self,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# i made alias 'e' it is '$EDITOR'

mkIf (mac "pcRyazenka" || mac "thinkpadT14" || mac "isoXtended") {
  hm = {
    home.shellAliases.e = "$EDITOR"; # cause defaultEditor

    programs.helix = {
      enable = true;

      defaultEditor = true;

      settings =
        (import ./settings.nix)
        // (optionalAttrs (mac' "isoXtended") {
          theme = "themo";
        });
    }
    // (optionalAttrs (mac' "isoXtended") {
      themes = import ./theme.nix {
        inherit
          lib
          config
          ;
      };

      languages = import ./languages.nix {
        inherit
          self
          pkgs
          lib
          ;
      };
    });
  };

  hmMime = mkMime {
    "Helix.desktop" = [
      "inode/empty"
      "text/*"
      "application/*"
    ];
  };
}
