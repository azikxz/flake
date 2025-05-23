{
  pkgs,
  config,
  ...
}:

let
  inherit (config.hm.stylix)
    iconTheme
    ;

  inherit (config.stylix)
    fonts
    ;

  mk =
    name:
    (pkgs.formats.ini { }).generate name {
      Appearance = {
        custom_palette = true;
        color_scheme_path = import ./color.nix {
          inherit
            pkgs
            config
            ;
        };

        icon_theme = iconTheme.dark;
        standard_dialogs = ''"default"'';
        style = ''"Fusion"'';
      };

      Fonts = {
        fixed = ''"${fonts.sansSerif.name},${toString fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"${fonts.sansSerif.name},${toString fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"'';
      };

      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 0;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 2;
        menus_have_icons = false;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
    };
in

{
  "qt5ct/qt5ct.conf".source = mk "qt5ct";
  "qt6ct/qt6ct.conf".source = mk "qt6ct";
}
