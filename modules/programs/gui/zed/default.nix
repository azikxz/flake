{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: gui text/code editor
# faster/better than codium

mkIf false {
  hm.programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
    ];

    extraPackages = with pkgs; [ nixd ];

    userSettings = {
      minimap.show = "never";
      scrollbar = {
        selected_text = false;
        selected_symbol = false;
        cursors = false;

        git_diff = true;
        search_results = true;
        diagnostics = "all";

        show = "auto";
        axes = {
          horizontal = true;
          vertical = true;
        };
      };

      tab_bar = {
        show = true;
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };

      toolbar = {
        breadcrumbs = false;
        quick_actions = false;
        selections_menu = false;
        agent_review = false;
        code_actions = false;
      };

      terminal = {
        blinking = "off";
        font_size = config.stylix.fonts.sizes.applications * 4.0 / 3.0;
        line_height = "standard";
        option_as_meta = true;
        button = false;
        toolbar.breadcrumbs = false;
        scrollbar.show = "never";
      };

      vim_mode = true;
      vim = {
        toggle_relative_line_numbers = true;
        use_multiline_find = true;
        use_smartcase_find = true;
      };

      indent_guides.enabled = true;

      autosave = "off";
      restore_on_startup = "none";
      auto_update = false;
      base_keymap = "VSCode";

      lsp = {
        nixd = {
          settings = {
            diagnostic = {
              suppress = [ "sema-extra-with" ];
            };
          };
          initialization_options = {
            formatting = {
              command = [
                "nixfmt"
                "--quiet"
                "--"
              ];
            };
          };
        };
      };

      features = {
        copilot = false;
      };

      telemetry.metrics = false;
    };
  };
}
