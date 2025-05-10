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

  module = lib.mkMerge [
    {
      programs = {
        cli = mkOn [
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
        gui =
          mkOn [
            "mpv"
            "nixcord"
            "obs"
            "qutebrowser"
            "spotify"
            "swayimg"
            "syncthing"
            "telegram"
            "zathura"
          ]
          // {
            libreoffice = on // {
              yazi = on;
            };
          };
      };
    }
    {
      shells = mkOn [
        "fish"
        "translate"
        "starship"
      ];
    }
    {
      themes =
        mkOn [
          "qt"
        ]
        // {
          stylix = on // {
            icon = "adwaita";
            cursor.size = 16;
          };
        };
    }
    {
      wm = (mkOn [ "hyprland" ]) // {
        terminals = mkOn [
          "kitty"
        ];
        misc = mkOn [
          "mako"
          "tofi"
          "wlogout"
        ];
      };
    }
    {
      games = mkOn [
        "mindustry"
        "minecraft"
        "openarena"
        "srb2"
        "wine"
        "umu"
      ];
    }
    {
      misc = mkOn [
        "dconf"
        "xdg"
      ];
    }
  ];
}
