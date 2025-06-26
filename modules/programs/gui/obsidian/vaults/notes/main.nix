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

      { pkg = obsidian-docxer; }
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

      {
        name = "floating-statusbar";
        text = # css
          ''
            body {
              --status-bar-position: absolute;
              --status-bar-radius: var(--radius-m);
            }
            body .status-bar {
              transform: translateX(calc(100% + 5px));
              transition: transform 300ms 150ms;
              bottom: 5px;
              right: 5px;
            }
            body .status-bar::before {
              width: 100%;
              min-height: 100%;
              content: " ";
              position: absolute;
              left: 0;
              bottom: 0;
              transform: translateX(-100%);
            }
            body .status-bar:hover {
              transform: none;
              transition: transform 300ms 150ms;
            }
          '';
      }

      {
        name = "docxer-hide";
        text = # css
          ''
            #docxer-header { display: none !important;  }
          '';
      }
    ];

    hotkeys = {
      "app:delete-file" = [
        {
          key = "D";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "app:go-back" = [
        {
          key = "ArrowLeft";
          modifiers = [ "Alt" ];
        }
      ];
      "app:go-forward" = [
        {
          key = "ArrowRight";
          modifiers = [ "Alt" ];
        }
      ];
      "app:open-sandbox-vault" = [
        {
          key = "'";
          modifiers = [ "Alt" ];
        }
      ];
      "app:open-settings" = [
        {
          key = ";";
          modifiers = [ "Alt" ];
        }
      ];
      "app:open-vault" = [
        {
          key = "'";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "canvas:export-as-image" = [
        {
          key = "M";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "canvas:new-file" = [
        {
          key = "M";
          modifiers = [ "Alt" ];
        }
      ];
      "command-palette:open" = [
        {
          key = " ";
          modifiers = [ "Alt" ];
        }
      ];
      daily-notes = [
        {
          key = "D";
          modifiers = [ "Alt" ];
        }
      ];
      "editor:attach-file" = [
        {
          key = "T";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "editor:delete-paragraph" = [ ];
      "editor:follow-link" = [ ];
      "editor:insert-link" = [ ];
      "editor:insert-table" = [
        {
          key = "T";
          modifiers = [ "Alt" ];
        }
      ];
      "editor:open-link-in-new-leaf" = [ ];
      "editor:open-link-in-new-split" = [ ];
      "editor:open-link-in-new-window" = [ ];
      "editor:open-search" = [
        {
          key = "/";
          modifiers = [ "Shift" ];
        }
      ];
      "editor:open-search-replace" = [ ];
      "editor:rename-heading" = [
        {
          key = "R";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "editor:save-file" = [
        {
          key = "S";
          modifiers = [ "Alt" ];
        }
        {
          key = "S";
          modifiers = [ "Mod" ];
        }
      ];
      "editor:toggle-bold" = [ ];
      "editor:toggle-checklist-status" = [ ];
      "editor:toggle-comments" = [
        {
          key = "C";
          modifiers = [ "Mod" ];
        }
      ];
      "editor:toggle-italics" = [ ];
      "file-explorer:new-file" = [
        {
          key = "A";
          modifiers = [ "Alt" ];
        }
      ];
      "file-explorer:new-file-in-current-tab" = [
        {
          key = "A";
          modifiers = [
            "Alt"
            "Mod"
          ];
        }
      ];
      "file-explorer:new-file-in-new-pane" = [
        {
          key = "A";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "file-explorer:new-folder" = [
        {
          key = "F";
          modifiers = [ "Alt" ];
        }
      ];
      "global-search:open" = [
        {
          key = "/";
          modifiers = [ "Alt" ];
        }
      ];
      "graph:open" = [
        {
          key = "G";
          modifiers = [ "Alt" ];
        }
      ];
      "graph:open-local" = [
        {
          key = "G";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "markdown:add-metadata-property" = [ ];
      "markdown:toggle-preview" = [ ];
      "omnisearch:show-modal" = [
        {
          key = "L";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "omnisearch:show-modal-infile" = [
        {
          key = "L";
          modifiers = [ "Alt" ];
        }
      ];
      "switcher:open" = [
        {
          key = "Enter";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:close" = [
        {
          key = "Q";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:close-others" = [
        {
          key = "Q";
          modifiers = [
            "Alt"
            "Shift"
          ];
        }
      ];
      "workspace:close-window" = [ ];
      "workspace:copy-path" = [
        {
          key = "C";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:edit-file-title" = [
        {
          key = "R";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:goto-last-tab" = [ ];
      "workspace:new-tab" = [
        {
          key = "W";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:next-tab" = [ ];
      "workspace:previous-tab" = [ ];
      "workspace:show-trash" = [
        {
          key = "\\";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:toggle-stacked-tabs" = [
        {
          key = "Tab";
          modifiers = [ "Alt" ];
        }
      ];
      "workspace:undo-close-pane" = [ ];

      # plugins
      "obsidian-minimal-settings:toggle-colorful-headings" = [
        {
          key = "U";
          modifiers = [ "Alt" ];
        }
      ];
      "obsidian-minimal-settings:toggle-minimal-focus-mode" = [
        {
          key = "I";
          modifiers = [ "Alt" ];
        }
      ];

      "app:toggle-left-sidebar" = [
        {
          "key" = "[";
          "modifiers" = [ "Alt" ];
        }
      ];
      "app:toggle-right-sidebar" = [
        {
          "key" = "]";
          "modifiers" = [ "Alt" ];
        }
      ];
      "editor:toggle-source" = [
        {
          "key" = " ";
          "modifiers" = [ "Shift" ];
        }
      ];
    };

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
