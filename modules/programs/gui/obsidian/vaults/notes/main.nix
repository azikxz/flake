{
  pkgs,
  lib,
  config,
  ...
}:

with pkgs.obsidian-plugins;
let
  helixBinds = true;
in

{
  target = lib.removePrefix (
    config.hm.home.homeDirectory + "/"
  ) config.hm.services.syncthing.settings.folders.notes.path;

  settings = {
    app = {
      tabSize = 2;
      vimMode = !helixBinds;
      defaultViewMode = "preview";
      livePreview = false;
      readableLineLength = true;
      showLineNumber = true;
      showInlineTitle = false;
    };

    appearance = {
      cssTheme = "Minimal";
      accentColor = config.lib.stylix.colors.withHashtag.base04;
      showRibbon = false;
      nativeMenus = false;
    };

    themes = [
      { pkg = minimal; }
    ];

    corePlugins = [
      {
        name = "canvas";
        settings = {
          newFileLocation = "folder";
          newFileFolderPath = "Inbox";
          defaultWheelBehavior = "zoom";
          snapToObjects = true;
          snapToGrid = true;
          cardLabelVisibility = "hover";
        };
      }
      {
        name = "daily-notes";
        settings = {
          format = "YYYY-MM-DD";
        };
      }
    ]
    ++ [
      "audio-recorder"
      "bookmarks"
      "command-palette"
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
      {
        pkg = minimal-settings;
        settings = import ./minimal-settings.nix;
      }

      {
        pkg = style-settings;
        settings = import ./style-settings.nix {
          inherit
            config
            ;
        };
      }

      {
        pkg = helix;
        settings = {
          enableHelixKeybindings = helixBinds;
          cursorInInsertMode = "bar";
        };
      }

      {
        pkg = omnisearch;
        settings = {
          vimLikeNavigationShortcut = true;
          fuzziness = "2";
          simpleSearch = true;
        };
      }

      {
        pkg = prettier;
        settings = {
          version = 20002;

          settings = {
            formatOnSave = true;
            formatOnFileChange = true;
            formatCodeBlock = true;

            removeExtraSpaces = false;
            addTrailingSpaces = true;
            languageMappings = { };

            formatOptions = {
              trailingComma = "es5";
              tabWidth = 4;
              semi = true;
              singleQuote = true;
            };

            ignorePatterns = ''
              **/.git
              **/.svn
              **/.hg
              **/node_modules
            '';
          };
        };
      }

      { pkg = docxer; }
    ];

    hotkeys = import ./binds.nix;

    cssSnippets = import ./snippets.nix {
      inherit
        config
        ;
    };
  };
}
