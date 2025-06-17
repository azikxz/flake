{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm = {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        app = {
          vimMode = true;
          tabSize = 2;
          defaultViewMode = "preview";
          livePreview = false;
          readableLineLength = true;
          showLineNumber = true;
        };

        corePlugins =
          let
            mk = name: options: {
              inherit
                name
                options
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
      };
    };
  };
}
