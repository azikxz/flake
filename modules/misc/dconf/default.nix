{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# shitass

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.dconf = {
    settings =
      let
        gn = "org/gnome";
        gnDesk = gn + "/desktop";
        nemo = "org/nemo";
      in
      {
        "io/bassi/Amberol" = {
          background-play = true;
          enable-recoloring = true;
          replay-gain = "track";
        };

        "${gn}/World/Secrets/last-opened-database" = {
          generator-length = 24;
          generator-use-numbers = true;
        };

        "${gn}/system/location".enabled = true;

        "${gnDesk}/wm/preferences" = {
          button-layout = "";
        };

        "${gnDesk}/applications/terminal" = {
          exec =
            if config.hm.programs.kitty.enable then
              "kitty"
            else if config.hm.programs.foot.enable then
              "foot"
            else
              "xterm";
        };
      };
  };
}
