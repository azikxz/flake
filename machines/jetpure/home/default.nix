{ x, config, ... }:
let
  inherit (x) on off umport;
in
{
  imports = umport {
    path = ./.;
    exclude = [
      ./default.nix
      ./pkgs
    ];
  };
  module = {
    programs = {
      cli = {
        bat = on;
        cava = on;
        eza = on;
        fd = on;
        fetch = on;
        fzf = on;
        git = on;
        helix = on;
        joshuto = off;
        legendary = on;
        lsd = off;
        micro = off;
        ripgrep = on;
        rustmission = on;
        top = on;
        yazi = on;
        zoxide = on;
      };
      gui = {
        floorp = off;
        minecraft = on // {
          cli = off;
        };
        mpv = on;
        obs = on;
        qbittorrent = on;
        qutebrowser = on;
        music = {
          amberol = on;
          spotify = on;
        };
        swayimg = on;
        syncthing = on;
        telegram = on // {
          walogram = on // {
            mode = "solid";
          };
        };
        zed = off;
      };
    };
    shells = {
      fish = on;
      nushell = off;
      tmux = off;
      zsh = off;
      starship = on;
    };
    themes = {
      gtk = on; # GTK APPS
      qt = on; # QT APPS
      stylix = on // {
        icon = "adwaita";
        cursor = with config.lib.stylix.colors.withHashtag; {
          size = 16;
          bg = "${base0E}";
          ol = "${base00}";
          ac = "${base0E}";
        };
      };
    };
    wm = {
      hyprland = on;
      sway = off;
      terminals = {
        kitty = on;
        foot = off;
        wezterm = off;
      };
      misc = {
        mako = on;
        nwg = off;
        rofi = off;
        tofi = on;
        waybar = off;
        wlogout = on;
        wob = off;
        yofi = off;
      };
    };
    misc = {
      dconf = on;
      xdg.mime = on;
    };
  };
}
