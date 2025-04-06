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
  theme = add.theme;
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
        inherit theme;
        colorScheme = "custom";
        customColorScheme = import ./theme.nix {
          inherit
            config
            ;
        };
      }
      // (lib.genAttrs [
        "enabledExtensions"
        "enabledSnippets"
        "enabledCustomApps"
      ] (n: add.${n}));
  };
}
