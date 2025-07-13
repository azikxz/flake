{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/umu" ];

  environment = {
    shellAliases.uwu = "umu-run";

    systemPackages = with pkgs; [
      (umu-launcher.override {
        extraEnv = {
          PROTON_ENABLE_WAYLAND = 1;
          PROTONPATH = toString self'.proton-umu.steamcompattool;

          WINEPREFIX =
            if (paths.winePrefix != null) then
              paths.winePrefix
            else if (paths.winePrefix == null && paths.persist != null) then
              (concatStringsSep "/" [
                paths.persist
                "UnifiedPrefix"
              ])
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
