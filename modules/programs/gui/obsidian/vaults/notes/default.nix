{
  pkgs,
  lib,
  config,
  ...
}:

with pkgs;

{
  options = {
    settings = lib.mkOption {
      type = lib.types.anything;
      default = { };
    };

    target = lib.mkOption {
      type = lib.types.anything;
      default = { };
    };
  };

  config = {
    target = lib.removePrefix (
      config.hm.home.homeDirectory + "/"
    ) config.hm.services.syncthing.settings.folders.notes.path;

    settings = {
      app = {
        vimMode = true;
        tabSize = 2;
        defaultViewMode = "preview";
        livePreview = false;
        readableLineLength = true;
        showLineNumber = true;
      };

      appearance = {
        "cssTheme" = "Minimal";
        "accentColor" = "#ffffff";
        showRibbon = false;
        nativeMenus = false;
      };

      themes =
        let
          mk = pkg: {
            inherit
              pkg
              ;
          };
        in
        [
          (mk obsidian-minimal)
        ];

      corePlugins =
        let
          mk = name: settings: {
            inherit
              name
              settings
              ;
          };
        in
        [
          (mk "canvas" {
            newFileLocation = "folder";
            newFileFolderPath = "Inbox";
            defaultWheelBehavior = "zoom";
            snapToObjects = true;
            snapToGrid = true;
            cardLabelVisibility = "hover";
          })
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

      communityPlugins =
        let
          mk = pkg: settings: {
            inherit
              pkg
              settings
              ;
          };
        in
        [
          (mk obsidian-minimal-settings (import ./minimal-settings.nix))

          # (mk obsidian-style-settings (
          #   import ./style-settings.nix {
          #     inherit
          #       config
          #       ;
          #   }
          # ))
        ];

      cssSnippets =
        let
          mkT = name: text: {
            inherit
              name
              text
              ;
          };

          mkS = name: source: {
            inherit
              name
              text
              ;
          };
        in
        [
          (mkT "stop-blinking-cursor" # css
            ''.cm-cursorLayer { animation: none !important; }''
          )
        ];

      extraFiles = {
        ".obsidian.vimrc" = {
          target = "../.obsidian.vimrc";
          text = ''
            set clipboard=unnamed
            nnoremap Y y$
          '';
        };
      };
    };
  };
}
