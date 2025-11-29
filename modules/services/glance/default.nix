{
  lib,
  config,
  ...
}:

with lib;
let
  # cause stylix have'nt hsl colors
  # i snatched (спиздил) it from github
  mkHsl =
    (import ./mkHsl.nix {
      inherit
        lib
        config
        ;
    }).init;

  isRu = true;
in
# INFO:
# very customizable dashboard
# have many...many...many optins
# i'll update it often

mkIf (mac "pcRyazenka") {
  services.glance = {
    enable = true;
    openFirewall = true;

    environmentFile = config.sopsnix."services/glance";

    settings = import ./settings.nix {
      inherit
        lib
        config

        isRu
        mkHsl
        ;
    };
  };
}
