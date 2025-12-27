{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.stylix)
    iconTheme
    ;

  prg = config.programs;
in
# INFO:
# take screenshots and edit them

mkIf (prg.hyprland.enable || prg.niri.enable) {
  hm.services.dunst = {
    enable = true;

    iconTheme = {
      name = if (config.stylix == "dark") then iconTheme.dark else iconTheme.light;

      size = "64x64";

      inherit (iconTheme)
        package
        ;
    };

    settings = with config.lib.stylix.colors.withHashtag; {
      global = {
        width = 400;
        corner_radius = 12;

        alignment = "left";
        format = "<b>[%a]</b>\\n<b>%s</b>\\n%b";

        origin = "top-right";
        offset = concatStringsSep "x" [
          "30"
          "30"
        ];

        icon_path =
          concatMapStringsSep ":"
            (
              category:
              "${iconTheme.package}/share/icons/${
                if (config.stylix == "dark") then iconTheme.dark else iconTheme.light
              }/${config.hm.services.dunst.iconTheme.size}/${category}"
            )
            [
              "actions"
              "apps"
              "categories"
              "devices"
              "emblems"
              "emotes"
              "mimetypes"
              "places"
              "status"
              "symbolic"
            ];
      };

      urgency_normal = {
        frame_color = mkForce base04;
      };
    };
  };
}
