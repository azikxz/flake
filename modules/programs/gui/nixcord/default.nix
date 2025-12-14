{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# enchnced vesktop

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/equibop" ];

  hm.programs.nixcord = {
    enable = true;

    discord.enable = false; # why?
    equibop.enable = true; # equibop is newgen vesktop

    equibopConfig = import ./settings.nix {
      inherit
        lib
        config
        ;
    };
  };

  hmMime = mkMime {
    "vesktop.desktop" = [ "x-scheme-handler/discord" ];
  };
}
