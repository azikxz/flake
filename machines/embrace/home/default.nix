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
        archivers = on;
        common = on;
        cava = on;
        fetch = on;
        helix = on;
        top = on;
        yazi = on;
      };
      gui = {
        keepass = on;
        mpv = on;
        qbittorrent = on;
        qutebrowser = on;
        music.spotify = on;
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
      translate = on;
      starship = on;
    };
    themes = {
      gtk = on; # GTK APPS
      qt = on; # QT APPS
      stylix = on // {
        cursor.size = 24;
      };
    };
    wm = {
      hyprland = on;
      terminals.kitty = on;
      misc = {
        mako = on;
        tofi = on;
        waybar = on;
        wlogout = on;
        wob = on;
      };
    };
    misc = {
      dconf = on;
      xdg.mime = on;
    };
  };
}
