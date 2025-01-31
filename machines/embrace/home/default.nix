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
        common = on;
        cava = on;
        fetch = on;
        helix = on;
        joshuto = off;
        legendary = off;
        lsd = off;
        micro = off;
        rustmission = off;
        top = on;
        yazi = on;
      };
      gui = {
        chromium = on;
        minecraft = off // {
          cli = off;
        };
        mpv = on;
        obs = off;
        qbittorrent = on;
        qutebrowser = on;
        music = {
          amberol = off;
          spotify = on;
        };
        swayimg = on;
        syncthing = on;
        telegram = {
          client = "64gram";
          walogram = on // {
            mode = "solid";
          };
        };
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
      sway = off;
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
