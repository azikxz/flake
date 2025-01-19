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
  a = (
    oldAttrs: {
      installPhase = # sh
        ''
          runHook preInstall
          dst_opentype=$out/share/fonts/opentype/NerdFonts
          dst_truetype=$out/share/fonts/truetype/NerdFonts
          find -name \*.otf -exec mkdir -p $dst_opentype \; -exec cp -p {} $dst_opentype \;
          find -name \*.ttf -exec mkdir -p $dst_truetype \; -exec cp -p {} $dst_truetype \;
          runHook postInstall
        '';
    }
  );
in
{
  options = {
    module.themes.stylix = {
      enable = mkBool;
      image = mkOpt.str;
      icon = mkOpt.str;
      cursor = {
        size = mkOpt.int;
        bg = mkOpt.str;
        ol = mkOpt.str;
        ac = mkOpt.str;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      with nerd-fonts;
      [
        corefonts
        (tinos.overrideAttrs a)
        (code-new-roman.overrideAttrs a)
        (dejavu-sans-mono.overrideAttrs a)
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
        package = pkgs.papirus-icon-theme.override { color = cfg.icon; };
      };
      fonts = with config.stylix.fonts; {
        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = with pkgs.nerd-fonts; (jetbrains-mono.overrideAttrs a);
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
        qutebrowser = on;
        firefox = on;
        gtk = on;
      };
    };
  };
}
