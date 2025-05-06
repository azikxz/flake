{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.games.umu;
in

{
  options = {
    module.games.umu = {
      enable = mkBool false;
      proton = mkPkg pkgs.proton-ge-bin;
    };
  };

  config = mkIf cfg.enable {
    impermanence.dirs = [ ".local/share/umu" ];
    home = {
      shellAbbrs.uwu = "umu-run";
      packages = with pkgs; [
        (pkgs.umu-launcher.override {
          extraEnv = {
            SDL_VIDEODRIVER = mkForce "";
            WINEPREFIX = x.path.steamUnified;
            PROTONPATH = toString cfg.proton.steamcompattool;
            STORE = toString inputs.umu-database;
          };
        })
      ];
    };
    xdg.configFile."protonfixes" = {
      recursive = true;
      source = inputs.protonfixes;
    };
  };
}
