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
  wal = inputs.design;
  a = (
    oldAttrs: {
      installPhase = ''
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
        bg = mkOpt.str;
        ol = mkOpt.str;
        ac = mkOpt.str;
      };
    };
  };

  imports = with inputs; [ stylix.homeManagerModules.stylix ];
  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      with nerd-fonts;
      [
        corefonts
        (tinos.overrideAttrs a)
        (monaspace.overrideAttrs a)
        (space-mono.overrideAttrs a)
        (code-new-roman.overrideAttrs a)
        (dejavu-sans-mono.overrideAttrs a)
      ];
    stylix = True // {
      autoEnable = false;
      base16Scheme = "${wal}/base16/${x.theme}.yaml";
      image = "${wal}/wallpapers/paradise/${x.image}.jpg";
      cursor = with inputs.cursors.packages.${pkgs.system}; {
        size = 16;
        name = "GoogleDot-Custom";
        package = google-cursor.override {
          background_color = cfg.cursor.bg;
          outline_color = cfg.cursor.ol;
          accent_color = cfg.cursor.ac;
        };
      };
      iconTheme = True // {
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
        tmux = True;
        cava = True // {
          rainbow = True;
        };
        fish = True;
        nushell = True;
        # WM
        hyprland = True // {
          hyprpaper = True;
        };
        hyprpaper = True;
        sway = True;
        river = True;
        # MISC PROGRAMS
        foot = True;
        kitty = True;
        mako = False;
        rofi = True;
        bemenu = True;
        # TOOLS
        nixvim = True;
        yazi = True;
        fzf = True;
        bat = True;
        mangohud = True;
        # GUI
        spicetify = False;
        vesktop = True;
        qutebrowser = True;
        firefox = True;
        gtk = True;
      };
    };
  };
}
