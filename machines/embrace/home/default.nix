{ lib, ... }:

let
  inherit (lib.x) on off umport;
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
        figlet = off;
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
        chromium = off;
        keepass = on;
        minecraft = off;
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
      translate = on;
      zsh = off;
      starship = on;
    };
    themes = {
      gtk = on; # GTK APPS
      qt = on; # QT APPS
      stylix = on // {
        icon = "adwaita";
        cursor.size = 24;
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
