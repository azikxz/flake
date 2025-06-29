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

    programs.helix = {
      enable = true;

      defaultEditor = true;

      settings = import ./settings.nix // {
        keys = import ./binds.nix;
      };

      languages = import ./languages.nix {
        inherit
          self
          pkgs
          lib
          ;
      };

      themes = import ./theme.nix {
        inherit
          lib
          config
          ;
      };
    };
  };
}
