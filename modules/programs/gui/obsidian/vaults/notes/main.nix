{
  pkgs,
  lib,
  config,
  ...
}:

with pkgs.self';

{
  target = lib.removePrefix (
    config.hm.home.homeDirectory + "/"
  ) config.hm.services.syncthing.settings.folders.notes.path;

  settings = {
    app = {
      tabSize = 2;
      vimMode = true;
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
      { pkg = obsidian-minimal; }
    ];

    corePlugins =
      [
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
            format = "YYYY-MM-DD/HH:mm";
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
        pkg = obsidian-minimal-settings;
        settings = import ./minimal-settings.nix;
      }

      {
        pkg = obsidian-style-settings;
        settings = import ./style-settings.nix {
          inherit
            config
            ;
        };
      }

      {
        pkg = obsidian-helix;
        settings = {
          enableHelixKeybindings = false;
          cursorInInsertMode = "bar";
        };
      }

      {
        pkg = obsidian-omnisearch;
        settings = {
          vimLikeNavigationShortcut = true;
          fuzziness = "2";
          simpleSearch = true;
        };
      }

      { pkg = obsidian-prettier; }
    ];

    cssSnippets = [
      {
        name = "system-font";
        text = # css
          ''
            body
              {
                --font-default: "${config.stylix.fonts.monospace.name}";
                --zoom-factor: 1.2;
              }
            body.minimal-theme
              { --font-editor-override: "${config.stylix.fonts.sansSerif.name}"; }
          '';
      }

      {
        name = "stop-blinking-cursor";
        text = # css
          ''.cm-cursorLayer { animation: none !important; }'';
      }

      {
        name = "helix-remove-statusbar";
        text = # css
          ''
            .cm-hx-command-panel { display: none !important; }
            .cm-hx-status-panel  { display: none !important; }
          '';
      }
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
