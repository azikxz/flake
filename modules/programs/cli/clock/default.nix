{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  environment.systemPackages = with pkgs; [ tenki ];

  environment.shellAliases = {
    ter = "tenki \
          --fps 80 \
          --wind disable \
          --timer-color cyan \
          --mode rain";
  };
}
