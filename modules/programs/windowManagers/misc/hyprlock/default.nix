{
  inputs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "thinkpadT14" && config.programs.hyprland.enable) {
  hm = {
    programs.hyprlock = with config.lib.stylix.colors; {
      enable = true;

      settings = {
        general = {
          hide_cursor = true;
          immediate_render = true;
        };

        background = mkForce [
          {
            blur_passes = 2;
            path = inputs.wallpapers.plantFlower;
          }
        ];

        animations = {
          bezier = [
            "easeout, 0.5, 1, 0.9, 1"
            "easeoutback, 0.34, 1.22, 0.65, 1"
          ];

          animation = [
            "fade,       1, 3, easeout"
            "fadeOut,    1, 3, easeout"
            "inputField, 1, 1, easeoutback"
          ];
        };

        label = [
          {
            text = "$TIME";
            color = "rgb(${base05})";
            font_family = config.stylix.fonts.monospace.name;
            font_size = 96;
            halign = "center";
            position = "0, 160";
            text_align = "center";
            valign = "center";
          }

          {
            text = "cmd[update:1000] battery";
            color = "rgb(${base05})";
            font_size = config.stylix.fonts.sizes.applications;
            font_family = config.stylix.fonts.sansSerif.name;
            position = "-10, 0";
            halign = "right";
            valign = "bottom";
          }
        ];

        auth = {
          fingerprint.enabled = true;
        };
      };
    };

    stylix.targets.hyprlock.useWallpaper = false;
  };

  security.pam.services.hyprlock = { };
}
