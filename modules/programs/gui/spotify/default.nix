{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm = {
    programs.spicetify = {
      enable = true;

      inherit
        (import ./addons.nix {
          inherit
            inputs
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
  };
}
