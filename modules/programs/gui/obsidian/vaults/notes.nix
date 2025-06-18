{
  pkgs,
  lib,
  config,
  ...
}:

with pkgs;

{
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
        mk = pkg: {
          inherit
            pkg
            ;
        };
      in
      [
        (mk obsidian-minimal-settings)
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
}
