{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# just clocks...with effects

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.tenki ];

  hm.home.shellAliases = {
    ten = ''
      tenki --fps 80 \
        --wind disable \
        --timer-color cyan \
        --mode rain
    '';
  };
}
