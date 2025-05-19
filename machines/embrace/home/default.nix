{
  lib,
  ...
}:

let
  inherit (lib.x)
    umport
    mkOn
    on
    ;
in

{
  imports = umport {
    path = ./modules;
  };
  module = {
    programs = {
      cli = mkOn [
        "common"
        "cava"
        "fetch"
        "helix"
        "systop"
        "yazi"
      ];
      gui = mkOn [
        "mpv"
        "qutebrowser"
        "spotify"
        "swayimg"
        "syncthing"
        "telegram"
        "zathura"
      ];
    };
    shells = mkOn [
      "fish"
      "translate"
      "starship"
    ];
    themes =
      mkOn [
        "qt"
      ]
      // {
        stylix = on // {
          icon = "paleorange";
        };
      };
    wm = (mkOn [ "hyprland" ]) // {
      terminals = mkOn [
        "kitty"
      ];
      misc = mkOn [
        "mako"
        "tofi"
        "waybar"
        "wlogout"
      ];
    };
    games = mkOn [
      "minecraft"
      "umu"
    ];
    misc = mkOn [
      "dconf"
      "impermanence"
      "xdg"
    ];
  };
}
