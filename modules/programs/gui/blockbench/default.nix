{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  plugins = false; # WARN: it doesnt works
in

mkIf (itIs == "desktop") {
  environment.systemPackages = with pkgs; [ blockbench ];

  hm.xdg = {
    configFile =
      {
        "Blockbench/stylix.bbtheme".text = builtins.toJSON {
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
      // (mkIf plugins (
        listToAttrs (
          map
            (plugin: {
              name = "Blockbench/plugins/${plugin.name}.js";
              value.source = pkgs.fetchurl {
                inherit (plugin)
                  url
                  sha256
                  ;
              };
            })
            (
              let
                jannis = "https://raw.githubusercontent.com/JannisX11/blockbench-plugins/refs/heads/master/plugins/";
                ewan = "https://raw.githubusercontent.com/ewanhowell5195/blockbenchPlugins/refs/heads/main/";
              in
              [
                {
                  name = "export_to_blender";
                  url = jannis + "export_to_blender/export_to_blender.js";
                  sha256 = "sha256-Fmy45afsB2XI33Q/aSgtyic/jJNnrPDIVXuFgY1EW8s=";
                }
                {
                  name = "emf_animation_addon";
                  url = jannis + "emf_animation_addon/emf_animation_addon.js";
                  sha256 = "sha256-OlguQx+yZTaBsM1R5NcO4YHaZ45LXKgqZGVrYgvPzZg=";
                }
                {
                  name = "colour_gradient_generator";
                  url = ewan + "colour_gradient_generator/colour_gradient_generator.js";
                  sha256 = "sha256-vCJBZ31mX9YECThi8TUtQLLA6g4kADB9WD6RbP302/o=";
                }
                {
                  name = "cem_template_loader";
                  url = ewan + "cem_template_loader/cem_template_loader.js";
                  sha256 = "sha256-3fqEDo7TQwixA6oJiYJDl9AU/p0FUkAg7Q8hkLRzlPA=";
                }
                {
                  name = "minecraft_item_wizard";
                  url = jannis + "minecraft_item_wizard/minecraft_item_wizard.js";
                  sha256 = "sha256-AYCWdIzhcOZtkPtGD69uWWxauxRvCzLyHhs/JQYaxBk=";
                }
                {
                  name = "animation_utils";
                  url = jannis + "animation_utils/animation_utils.js";
                  sha256 = "sha256-ZH+IZFjqOtRipa1lgREn2QOrVgXuZ95LWQDhnOhXurQ=";
                }
                {
                  name = "minecraft_entity_wizard";
                  url = jannis + "minecraft_entity_wizard/minecraft_entity_wizard.js";
                  sha256 = "sha256-HjYGvLOR9E/hO6plvbwc1Y34t8wDHqfXMOIVUjNxbcQ=";
                }
                {
                  name = "minecraft_title_generator";
                  url = ewan + "minecraft_title_generator/minecraft_title_generator.js";
                  sha256 = "sha256-IHrfACj311k9oYr45hTi0lI8OLwJc+F3jfAu+czG/10=";
                }
              ]
            )
        )
      ));

    desktopEntries.blockbench = {
      name = "Blockbench";
      comment = "Low-poly 3D modeling and animation software";
      exec = "${getExe pkgs.blockbench} --ozone-platform=wayland --ozone-platform-hint=auto %U";
      icon = "blockbench";
      type = "Application";
      categories = [ "3DGraphics" ];
      terminal = false;
    };
  };
}
