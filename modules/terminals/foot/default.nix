{
  lib,
  config,
  ...
}:

with lib;

mkIf false {
  hm.programs.foot = {
    enable = true;

    settings = {
      main = {
        pad = "20x20 center";
        resize-by-cells = "yes";
        letter-spacing = 0;
        font-size-adjustment = 1;
      };

      bell = {
        system = "no";
      };

      cursor = with config.lib.stylix.colors; {
        style = "block";
        color = "${base00} ${base06}";
      };
    };
  };
}
