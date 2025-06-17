{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [
    ".config/spotify"
    ".cache/spotify"
  ];

  hm.programs.spicetify = {
    enable = true;

    inherit
      (import ./addons.nix {
        inherit
          pkgs
          config
          ;
      })
      theme
      enabledExtensions
      enabledSnippets
      ;

    wayland = true;
    windowManagerPatch = true;

    colorScheme = "custom";
    customColorScheme = import ./theme.nix {
      inherit
        config
        ;
    };
  };
}
