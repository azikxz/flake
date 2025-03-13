{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.themes.stylix;
in

{
  options = {
    module.themes.stylix = {
      enable = mkBool false;
      icon = mkNull.str null;
      cursor.size = mkInt 12;
    };
  };

  imports = with inputs; [ niri.homeModules.stylix ];
  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      with nerd-fonts;
      [
        corefonts
        tinos
        code-new-roman
        dejavu-sans-mono
      ];
    stylix = on // {
      autoEnable = false;
      cursor = with inputs.cursors.packages.${pkgs.system}; {
        size = cfg.cursor.size;
        name = "GoogleDot-Custom";
        package =
          let
            mk = a: b: c: {
              background_color = a;
              outline_color = b;
              accent_color = c;
            };
          in
          google-cursor.override (
            with config.lib.stylix.colors.withHashtag;
            if x.sys.is == "laptop" then
              mk base08 base00 base08
            else if x.sys.is == "desktop" then
              mk base0E base00 base0E
            else
              mk base00 base05 base05
          );
      };
      iconTheme = on // {
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = with pkgs; papirus-icon-theme.override { color = cfg.icon; };
      };
      fonts = rec {
        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = with pkgs.nerd-fonts; jetbrains-mono;
        };
        serif = monospace;
        emoji = monospace;
        sizes = {
          desktop = 10;
          popups = 10;
          applications = 12;
          terminal = 12;
        };
      };
      targets = {
        # cli
        tmux = on;
        cava = on // {
          rainbow = on;
        };
        fish = on;
        nushell = on;
        # wm
        hyprland = on // {
          hyprpaper = on;
        };
        hyprpaper = on;
        niri = on;
        sway = on;
        river = on;
        # misc
        foot = on;
        kitty = on;
        mako = off;
        rofi = on;
        bemenu = on;
        # tools
        nixvim = on;
        yazi = on;
        fzf = on;
        bat = on;
        mangohud = on;
        # gui
        spicetify = off;
        mpv = on;
        nixcord = on;
        zathura = on;
        qutebrowser = on;
        firefox = on;
        floorp = on;
        halloy = on;
        gtk = on;
      };
    };
  };
}
