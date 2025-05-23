{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm.programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = import ./settings.nix;
  };
}
