{
  pkgs,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
  font = config.stylix.fonts;
  icon = config.stylix.iconTheme;
  mk =
    package: name:
    let
      st = "${toString package}/share/${name}/qss";
    in
    # toml
    ''
      [Appearance]
        color_scheme_path=${homeDirectory}/.config/${name}/colors/stylix.conf
        custom_palette=true
        icon_theme=${icon.dark}
        standard_dialogs=default
        style=Fusion
      [Fonts]
        fixed="${font.monospace.name},${toString font.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
        general="${font.monospace.name},${toString font.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
      [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=false
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3
        stylesheets=${st}/fusion-fixes.qss,${st}/scrollbar-simple.qss,${st}/sliders-simple.qss,${st}/tooltip-simple.qss,${st}/traynotification-simple.qss
      [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
    '';
in
{
  xdg.configFile =
    let
      inherit (pkgs.libsForQt5) qt5ct;
      inherit (pkgs) qt6ct;
    in
    {
      "qt5ct/qt5ct.conf".text = mk qt5ct "qt5ct";
      "qt6ct/qt6ct.conf".text = mk qt6ct "qt6ct";
    };
}
