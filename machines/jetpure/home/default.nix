{
  lib,
  ...
}:

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
        zen-browser = on;
      };
    };
    shells = {
      fish = on;
      translate = on;
      starship = on;
    };
    themes = {
      gtk = on;
      qt = on;
      stylix = on // {
        icon = "adwaita";
        cursor.size = 16;
      };
    };
    wm = {
      hyprland = on;
      niri = on;
      terminals.kitty = on;
      misc = {
        mako = on;
        tofi = on;
        wlogout = on;
      };
    };
    misc = {
      dconf = on;
      xdg.mime = on;
    };
  };
}
