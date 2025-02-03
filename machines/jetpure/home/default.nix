{ x, config, ... }:
let
  inherit (x) on off umport;
in
{
  imports = umport {
    path = ./.;
    exclude = [ ./default.nix ];
  };
  module = {
    programs = {
      cli = {
        archivers = on;
        common = on;
        cava = on;
        fetch = on;
        helix = on;
        joshuto = off;
        legendary = on;
        lsd = off;
        micro = off;
        rustmission = off;
        top = on;
        yazi = on;
      };
      gui = {
        chromium = on;
        keepass = on;
        minecraft = on;
        mpv = on;
        obs = on;
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
        zathura = on;
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
      gtk = on;
      qt = on;
      kvantum = off;
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
