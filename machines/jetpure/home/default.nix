{
  lib,
  ...
}:

let
  inherit (lib.x) on umport;
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
        mpv = on;
        nixcord = on;
        obs = on;
        qutebrowser = on;
        spotify = on;
        swayimg = on;
        syncthing = on;
        telegram = on;
        zathura = on;
      };
    };
    shells = {
      fish = on;
      translate = on;
      starship = on;
    };
    themes.stylix = on // {
      icon = "adwaita";
      cursor.size = 16;
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
    games = {
      mindustry = on;
      minecraft = on;
      openarena = on;
      srb2 = on;
      wine = on;
    };
    misc = {
      dconf = on;
      xdg.mime = on;
    };
  };
}
