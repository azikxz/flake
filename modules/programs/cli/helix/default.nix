{
  self,
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  hm = {
    home.shellAliases.e = "$EDITOR";

    programs.helix =
      {
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
      // (optionalAttrs (machine != "isoXtended") {
        languages = import ./languages.nix {
          inherit
            self
            pkgs
            lib
            ;
        };
      });
  };
}
