{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  environment.systemPackages = with pkgs; [ blockbench ];

  hm.xdg.configFile."Blockbench/stylix.bbtheme".text = builtins.toJSON {
    name = "Stylix theme (based on Crimson)";
    author = "by Azikx for ${system.userName}";
    css = ".dialog_sidebar .dialog_sidebar_pages li\n{ padding: 6px 10px; }\n\n.dialog_sidebar .dialog_sidebar_pages li.selected\n{\n  border-style: unset;\n  border-left: 3px solid var(--color-accent);\n}\n\n.dialog_handle\n{\n  font-size: 1.25em;\n  height: auto;\n}\n\n.dialog_bar > button.confirm_btn:not(:hover)\n{ border: 3px solid var(--color-accent); }\n\n#start_files li.format_entry\n{\n  padding-block: 5px;\n}\n\n.dialog_handle\n{\n  border-top-left-radius: var(--title_radius);\n  border-top-right-radius: var(--title_radius);\n  background-color: var(--color-back);\n  text-align: center;\n}\n\n#windows_window_menu li,\n.dialog_menu_button,\n.dialog_close_button,\n#tab_bar .project_tab:hover .project_tab_close_button,\n#tab_bar .project_tab.selected .project_tab_close_button,\n#tab_bar .project_tab .project_tab_close_button.unsaved\n{ display: none; }\n";
    colors = with config.lib.stylix.colors.withHashtag; {
      ui = base00;
      back = base00;
      dark = base00;
      border = base02;
      selected = base03;
      button = base02;
      bright_ui = base00;
      accent = base0D;
      frame = base00;
      text = base06;
      light = base07;
      accent_text = base00;
      bright_ui_text = base06;
      subtle_text = base05;
      grid = base0E;
      wireframe = base0D;
      checkerboard = base02;
    };
  };
}
