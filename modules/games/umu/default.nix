{
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  persist.user.dirs = [ ".local/share/umu" ];

  environment = {
    shellAliases.uwu = "umu-run";

    systemPackages = with pkgs; [
      (umu-launcher.override {
        extraEnv = {
          PROTON_USE_NTSYNC = "1";

          SDL_VIDEODRIVER = mkForce "";

          WINEPREFIX = paths.winePrefix;

          PROTONPATH = toString proton-ge-bin.steamcompattool;

          STORE = toString inputs.umu-database;
        };
      })
    ];
  };

  hm.xdg.configFile."protonfixes" = {
    recursive = true;

    source = inputs.protonfixes;
  };
}
