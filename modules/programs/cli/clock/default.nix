{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  environment.systemPackages = with pkgs; [ tenki ];

  environment.shellAliases = {
    ter = "tenki \
          --fps 80 \
          --wind disable \
          --timer-color cyan \
          --mode rain";
  };
}
