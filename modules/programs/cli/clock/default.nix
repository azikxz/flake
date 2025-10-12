{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.tenki ];

  hm.home.shellAliases = {
    ter = ''
      tenki --fps 80 \
        --wind disable \
        --timer-color cyan \
        --mode rain
    '';
  };
}
