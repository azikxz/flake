{
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
      cursor.size = mkInt 12;
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
        package =
          let
            mode =
              with config.lib.stylix.colors.withHashtag;
              if x.sys.is == "laptop" then
                {
                  background_color = "${base08}";
                  outline_color = "${base00}";
                  accent_color = "${base08}";
                }
              else if x.sys.is == "desktop" then
                {
                  background_color = "${base0E}";
                  outline_color = "${base00}";
                  accent_color = "${base0E}";
                }
              else
                {
                  background_color = "${base00}";
                  outline_color = "${base05}";
                  accent_color = "${base05}";
                };
          in
          google-cursor.override mode;
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
        floorp = on;
        halloy = on;
        gtk = on;
      };
    };
  };
}
