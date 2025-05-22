{
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [ ".local/share/umu" ];

  environment.shellAliases.uwu = "umu-run";

  hm = {
    home.packages = with pkgs; [
      (umu-launcher.override {
        extraEnv = {
          SDL_VIDEODRIVER = mkForce "";

          WINEPREFIX = paths.winePrefix;

          PROTONPATH = toString proton-ge-bin.steamcompattool;

          STORE = toString inputs.umu-database;
        };
      })
    ];

    xdg.configFile."protonfixes" = {
      recursive = true;

      source = inputs.protonfixes;
    };
  };
}
