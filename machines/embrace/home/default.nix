{
  x,
  config,
  ...
}:
let
  inherit (x) True False umport;
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
        bat = True;
        cava = True;
        eza = True;
        fd = True;
        fetch = True;
        fzf = True;
        git = True;
        helix = True;
        joshuto = False;
        legendary = False;
        lsd = False;
        micro = False;
        ripgrep = True;
        rustmission = False;
        top = True;
        yazi = True;
        zoxide = True;
      };
      gui = {
        chromium = True;
        floorp = False;
        minecraft = False // {
          cli = False;
        };
        mpv = True;
        obs = False;
        qbittorrent = True;
        qutebrowser = True;
        music = {
          amberol = True;
          spotify = False;
        };
        swayimg = True;
        syncthing = True;
        telegram = True // {
          walogram = True // {
            mode = "solid";
          };
        };
        zed = False;
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
          size = 24;
          bg = "${base08}";
          ol = "${base00}";
          ac = "${base08}";
        };
      };
    };
    wm = {
      hyprland = True;
      sway = True;
      terminals = {
        kitty = True;
        foot = False;
        wezterm = False;
      };
      misc = {
        flameshot = False;
        mako = True;
        nwg = False;
        rofi = False;
        tofi = True;
        waybar = True;
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
