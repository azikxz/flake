{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "thinkpadT14" && config.programs.hyprland.enable) {
  hm.services.hyprsunset = {
    enable = true;

    transitions = {
      sunrise = {
        calendar = "*-*-* 07:00:00";
        requests = [
          [ "identity" ]
        ];
      };

      sunset = {
        calendar = "*-*-* 21:00:00";
        requests = [
          [
            "temperature 3500"
            "gamme 60"
          ]
        ];
      };
    };
  };
}
