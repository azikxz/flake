{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  persist.user.dirs = [ ".config/vesktop" ];

  hm.programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = import ./settings.nix;
  };
}
