{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) callPackage;
  mk = path: (callPackage path { });
  cfg = config.module.programs.gui.obsidian;
in

{
  options = {
    module.programs.gui.obsidian = {
      enable = mkBool false;
    };
  };

  imports = [ ./module.nix ];
  config = mkIf cfg.enable {
    programs.obsidian = on // {
      vaults = {
        "Documents/Obsidian/master".enable = true;
      };
      defaultSettings = {
        app = {
          defaultViewMode = "preview";
          livePreview = false;
          readableLineLength = true;
          showLineNumber = true;
          tabSize = 2;
        };
        corePlugins =
          [
            {
              name = "canvas";
              options = {
                newFileLocation = "folder";
                newFileFolderPath = "Inbox";
                defaultWheelBehavior = "zoom";
              };
            }
          ]
          ++ [
            "bookmarks"
            "canvas"
          ];
        communityPlugins = [
          # (mk ./obs-style-set.nix)
        ];
        cssSnippets = [ ];
        themes = [ ];
        hotkeys = {
          "command-palette:open" = [
            {
              key = "F1";
            }
          ];
          "app:open-help" = [ ];
          "editor:swap-line-down" = [
            {
              modifiers = [ "Alt" ];
              key = "ArrowDown";
            }
          ];
        };
      };
    };
  };
}
