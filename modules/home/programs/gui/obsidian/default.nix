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
        "Obsidian/spellnotes".enable = true;
      };
      defaultSettings = {
        app = {
          vimMode = true;
          defaultViewMode = "preview";
          livePreview = false;
          readableLineLength = true;
          tabSize = 2;
          showLineNumber = true;
        };
        corePlugins =
          [
            {
              name = "canvas";
              options = {
                newFileLocation = "folder";
                newFileFolderPath = "Inbox";
                defaultWheelBehavior = "zoom";
                snapToObjects = true;
                snapToGrid = true;
                cardLabelVisibility = "hover";
              };
            }
          ]
          ++ [
            "audio-recorder"
            "bookmarks"
            "command-palette"
            "daily-notes"
            "editor-status"
            "file-explorer"
            "graph"
            "markdown-importer"
            "note-composer"
            "outgoing-link"
            "outline"
            "page-preview"
            "properties"
            "slash-command"
            "slides"
            "switcher"
            "tag-pane"
            "word-count"
            "workspaces"
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
