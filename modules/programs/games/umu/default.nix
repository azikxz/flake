{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  PROTONPATH = pkgs._24.proton-ge-bin.steamcompattool;
in
# INFO:
# my favorite launcher for exe

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/umu" ];

  hmPackages = with pkgs; [
    (umu-launcher.override {
      extraEnv = {
        # PROTON_ENABLE_WAYLAND = 1;
        inherit PROTONPATH;

        WINEPREFIX =
          if (paths.winePrefix != null) then
            paths.winePrefix
          else
            (concatStringsSep "/" [
              config.hm.home.homeDirectory
              "UnifiedPrefix"
            ]);
      };
    })

    vkbasalt
  ];

  hm = {
    home.shellAliases.uwu = "umu-run";

    xdg.configFile."protonfixes" = {
      recursive = true;

      source = inputs.protonfixes;
    };
  };
}
