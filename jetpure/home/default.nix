{ x, config, ... }:
let
  inherit (x) True False umport;
in
{
  imports = umport { path = ../parts/home; };
  module = {
    programs = {
      cli = {
        bat = True;
        cava = True;
        eza = True;
        fd = True;
        fetch = True;
        fzf = True;
        git = True;
        helix = True;
        joshuto = False;
        legendary = True;
        lsd = False;
        micro = False;
        ripgrep = True;
        rustmission = True;
        top = True;
        yazi = True;
        zoxide = True;
      };
      gui = {
        floorp = False;
        minecraft = True // {
          cli = False;
        };
        mpv = True;
        obs = True;
        qbittorrent = True;
        qutebrowser = True;
        music = {
          amberol = True;
          spotify = True;
        };
        swayimg = True;
        syncthing = True;
        walogram = True // {
          mode = "solid";
        };
        zed = False;
      };
      custom = {
        anicli = True;
        keydex = True;
      };
    };
    shells = {
      fish = True;
      nushell = False;
      tmux = False;
      zsh = False;
      starship = True;
    };
    themes = {
      gtk = True; # GTK APPS
      qt = True; # QT APPS
      stylix = True // {
        icon = "adwaita";
        cursor = with config.lib.stylix.colors.withHashtag; {
          bg = "${base0E}";
          ol = "${base00}";
          ac = "${base0E}";
        };
      };
    };
    wm = {
      hyprland = True;
      sway = False;
      terminals = {
        kitty = True;
        foot = False;
        wezterm = False;
      };
      misc = {
        mako = True;
        nwg = False;
        rofi = True;
        tofi = True;
        waybar = False;
        wlogout = True;
        wob = False;
        yofi = False;
      };
    };
    misc = {
      dconf = True;
      xdg.mime = True;
    };
  };
}
