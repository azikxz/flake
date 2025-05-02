{
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
    home.packages = with pkgs; [
      (pkgs.umu-launcher.override {
        extraEnv = {
          SDL_VIDEODRIVER = mkForce "";
          WINEPREFIX = x.path.steamUnified;
          PROTONPATH = toString cfg.proton.steamcompattool;
          STORE = toString (
            pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/Open-Wine-Components/umu-database/refs/heads/main/umu-database.csv";
              sha256 = "sha256-O6s8BD9ybOLx0t3NkNhLGFLva10M9ioLcSRGCQiscv0=";
            }
          );
        };
      })
    ];
    xdg.configFile."protonfixes" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "Open-Wine-Components";
        repo = "umu-protonfixes";
        rev = "f04757bc1bc973f9b446155e4444ec936701708b";
        hash = "sha256-8zRJuaYuZkIeh/OAdZYE4/ev8YBeBEXG8r1FmJGsdUM=";
      };
    };
  };
}
