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
        common = on;
        cava = on;
        fetch = on;
        figlet = on;
        helix = on;
        legendary = on;
        systop = on;
        yazi = on;
      };
      gui = {
        chromium = off;
        keepass = on;
        minecraft = on;
        mpv = on;
        obs = on;
        qutebrowser = on;
        music = {
          amberol = off;
          spotify = on;
        };
        nixcord = on;
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
      translate = on;
      zsh = off;
      starship = on;
    };
    themes = {
      gtk = on;
      qt = on;
      kvantum = off;
      stylix = on // {
        icon = "adwaita";
        cursor.size = 16;
      };
    };
    wm = {
      hyprland = on;
      sway = off;
      niri = on;
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
