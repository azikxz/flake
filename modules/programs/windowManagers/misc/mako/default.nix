{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# piece of shit
# (im working on swaync)

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.services.mako = with config.lib.stylix.colors.withHashtag; {
    enable = true;

    settings =
      let
        mk = a: b: c: {
          background-color = a;
          border-color = b;
          text-color = c;
        };
      in
      {
        "urgency=low" = mk base00 base0D base06;
        "urgency=high" = mk base00 base0C base06;
        "urgency=critical" = mk base00 base0A base06;

        icons = true;
        actions = false;
        anchor = "top-right";
        layer = "overlay";
        sort = "+time";
        margin = "20, 20, 20";

        border-radius = 8;
        border-size = 2;
        font = concatStringsSep " " [
          config.stylix.fonts.sansSerif.name
          (toString config.stylix.fonts.sizes.applications)
        ];
        background-color = base01;
        border-color = base0E;
        text-color = base06;
        max-visible = 5;
        default-timeout = 0;
      };
  };

  systemd.user.services.mako = {
    description = "Autostart for mako";

    script = getExe config.hm.services.mako.package;

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
