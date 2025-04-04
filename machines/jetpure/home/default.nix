{
  lib,
  ...
}:

let
  inherit (lib.x) umport mkGrpOn on;
in

{
  imports = umport { path = ./modules; };

  module = {
    programs = {
      cli = mkGrpOn [
        "common"
        "cava"
        "develop"
        "fetch"
        "figlet"
        "helix"
        "imageEdit"
        "legendary"
        "systop"
        "yazi"
      ];
      gui = mkGrpOn [
        "keepass"
        "mpv"
        "nixcord"
        "obs"
        "qutebrowser"
        "spotify"
        "swayimg"
        "syncthing"
        "telegram"
        "zathura"
      ];
    };
    shells = mkGrpOn [
      "fish"
      "translate"
      "starship"
    ];
    themes =
      mkGrpOn [
        "qt"
      ]
      // {
        stylix = on // {
          icon = "adwaita";
          cursor.size = 16;
        };
      };
    wm = (mkGrpOn [ "hyprland" ]) // {
      terminals = mkGrpOn [
        "kitty"
      ];
      misc = mkGrpOn [
        "mako"
        "tofi"
        "wlogout"
      ];
    };
    games = mkGrpOn [
      "mindustry"
      "minecraft"
      "openarena"
      "srb2"
      "wine"
    ];
    misc = mkGrpOn [
      "dconf"
      "xdg"
    ];
  };
}
