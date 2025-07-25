{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  PROTONPATH = pkgs.proton-ge-bin.steamcompattool;
in

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/umu" ];

  environment = {
    shellAliases.uwu = "umu-run";

    systemPackages = with pkgs; [
      (umu-launcher.override {
        extraEnv = {
          PROTON_ENABLE_WAYLAND = 1;
          PROTON_USE_NTSYNC = 1;
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
  };

  hm.xdg.configFile."protonfixes" = {
    recursive = true;

    source = inputs.protonfixes;
  };
}
