{
  self,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: i made alias 'e' it is '$EDITOR'

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    home.shellAliases.e = "$EDITOR";

    programs.helix = {
      enable = true;

      defaultEditor = true;

      settings = import ./settings.nix // {
        keys = import ./binds.nix;
      };

      themes = import ./theme.nix {
        inherit
          lib
          config
          ;
      };
    }
    // (optionalAttrs (mac' "isoXtended") {
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
