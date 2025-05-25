{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".config/vesktop" ];

  hm.programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = import ./settings.nix;
  };
}
