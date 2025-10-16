{
  pkgs,
  lib,
  config,
  ...
}:

with pkgs.self';
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
      { pkg = obsidian.minimal; }
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
          format = "YYYY-MM-DD_HH:mm";
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
        pkg = obsidian.minimal-settings;
        settings = import ./minimal-settings.nix;
      }

      {
        pkg = obsidian.style-settings;
        settings = import ./style-settings.nix {
          inherit
            config
            ;
        };
      }

      {
        pkg = obsidian.helix;
        settings = {
          enableHelixKeybindings = helixBinds;
          cursorInInsertMode = "bar";
        };
      }

      {
        pkg = obsidian.omnisearch;
        settings = {
          vimLikeNavigationShortcut = true;
          fuzziness = "2";
          simpleSearch = true;
        };
      }

      {
        pkg = obsidian.prettier;
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

      { pkg = obsidian.docxer; }
    ];

    hotkeys = import ./binds.nix;

    cssSnippets = import ./snippets.nix {
      inherit
        config
        ;
    };
  };
}
