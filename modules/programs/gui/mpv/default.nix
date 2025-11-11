{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  theme = import ./theme.nix {
    inherit
      config
      lib
      ;
  };
  settings = import ./settings.nix {
    inherit pkgs lib;
  };
in
# WARN:
# by default anime4k is enabled
#
# INFO:
# best video player

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.mpv = {
    enable = true;

    bindings = import ./bindings.nix;

    scripts = import ./scripts.nix {
      inherit
        pkgs
        ;
    };

    scriptOpts = settings.script // theme.uosc;

    config = settings.config // theme.conf;

    extraInput = settings.extra;
  };

  hmMime = mkMime {
    "mpv.desktop" = [
      "video/*"
      "audio/*"
      "application/x-matroska"
    ];
  };
}
