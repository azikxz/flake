{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = with pkgs; [ tenki ];

  environment.shellAliases = {
    ter = ''
      tenki --fps 80 \
        --wind disable \
        --timer-color cyan \
        --mode rain
    '';
  };
}
