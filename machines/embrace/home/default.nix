{
  x,
  config,
  ...
}:
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
        legendary = off;
        lsd = off;
        micro = off;
        ripgrep = on;
        rustmission = off;
        top = on;
        yazi = on;
        zoxide = on;
      };
      gui = {
        chromium = on;
        floorp = off;
        minecraft = off // {
          cli = off;
        };
        mpv = on;
        obs = off;
        qbittorrent = on;
        qutebrowser = on;
        music = {
          amberol = on;
          spotify = off;
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
          size = 24;
          bg = "${base08}";
          ol = "${base00}";
          ac = "${base08}";
        };
      };
    };
    wm = {
      hyprland = on;
      sway = on;
      terminals = {
        kitty = on;
        foot = off;
        wezterm = off;
      };
      misc = {
        flameshot = off;
        mako = on;
        nwg = off;
        rofi = off;
        tofi = on;
        waybar = on;
        wlogout = on;
        wob = on;
        yofi = off;
      };
    };
    misc = {
      dconf = on;
      xdg.mime = on;
    };
  };
}
