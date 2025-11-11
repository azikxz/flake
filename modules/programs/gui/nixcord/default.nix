{
  lib,
  ...
}:

with lib;
# INFO:
# modded vesktop with wayland screencast

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/vesktop" ];

  hm.programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = import ./settings.nix;
  };

  hmMime = mkMime {
    "vesktop.desktop" = [ "x-scheme-handler/discord" ];
  };
}
