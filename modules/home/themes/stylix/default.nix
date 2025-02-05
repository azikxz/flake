{
  x,
  pkgs,
  lib,
  config,
  inputs,
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
      icon = mkStr "breeze";
      cursor = with config.lib.stylix.colors.withHashtag; {
        size = mkInt 12;
        bg = mkStr "${base04}";
        ol = mkStr "${base00}";
        ac = mkStr "${base04}";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      with nerd-fonts;
      [
        corefonts
        tinos
        code-new-roman
        dejavu-sans-mono
        (customPkgs "base16-preview" { })
      ];
    stylix = on // {
      autoEnable = false;
      cursor = with inputs.cursors.packages.${pkgs.system}; {
        size = cfg.cursor.size;
        name = "GoogleDot-Custom";
        package = google-cursor.override {
          background_color = cfg.cursor.bg;
          outline_color = cfg.cursor.ol;
          accent_color = cfg.cursor.ac;
        };
      };
      iconTheme = on // {
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = with pkgs; papirus-icon-theme.override { color = cfg.icon; };
      };
      fonts = with config.stylix.fonts; {
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
        # CLI
        tmux = on;
        cava = on // {
          rainbow = on;
        };
        fish = on;
        nushell = on;
        # WM
        hyprland = on // {
          hyprpaper = on;
        };
        hyprpaper = on;
        sway = on;
        river = on;
        # MISC PROGRAMS
        foot = on;
        kitty = on;
        mako = off;
        rofi = on;
        bemenu = on;
        # TOOLS
        nixvim = on;
        yazi = on;
        fzf = on;
        bat = on;
        mangohud = on;
        # GUI
        spicetify = off;
        vesktop = on;
        zathura = on;
        qutebrowser = on;
        firefox = on;
        gtk = on;
      };
    };
  };
}
