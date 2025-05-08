{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.spotify;
  add = import ./addons.nix {
    inherit
      inputs
      pkgs
      config
      ;
  };
in

{
  options = {
    module.programs.gui.spotify = {
      enable = mkBool false;
    };
  };

  imports = with inputs; [ spicetify.homeManagerModules.default ];
  config = mkIf cfg.enable {
    programs.spicetify =
      on
      // {
        inherit (add) theme;
        wayland = true;
        windowManagerPatch = true;
        colorScheme = "custom";
        customColorScheme = import ./theme.nix {
          inherit
            config
            ;
        };
      }
      // (genAttrs [
        "enabledExtensions"
        "enabledSnippets"
      ] (n: add.${n}));
  };
}
