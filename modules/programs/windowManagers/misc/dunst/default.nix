{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.stylix)
    icons
    ;

  prg = config.programs;
in
# INFO:
# blyat just perfect notificate

mkIf (prg.hyprland.enable || prg.niri.enable) {
  hm.services.dunst = {
    enable = true;

    iconTheme = {
      name = if (config.stylix == "dark") then icons.dark else icons.light;

      size = "64x64";

      inherit (icons)
        package
        ;
    };

    settings = with config.lib.stylix.colors.withHashtag; {
      global = {
        width = 400;
        corner_radius = 12;

        alignment = "left";
        format = "<b>[%a]</b>\\n<b>%s</b>\\n%b";
        vertical_alignment = "top";
        notification_limit = 4;

        origin = "top-right";
        offset = concatStringsSep "x" [
          "10"
          "10"
        ];

        icon_path =
          concatMapStringsSep ":"
            (
              category:
              "${icons.package}/share/icons/${
                if (config.stylix == "dark") then icons.dark else icons.light
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

      urgency_low.timeout = 3;

      urgency_normal = {
        timeout = 5;
        frame_color = mkForce base04;
      };

      urgency_critical.timeout = 0;
    };
  };
}
