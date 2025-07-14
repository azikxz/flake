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
          PROTONPATH =
            if (lib.mac "pcRyazenka") then
              (toString self'.proton-umu.steamcompattool)
            else if (lib.mac "thinkpadT14") then
              (toString proton-ge-bin.steamcompattool)
            else
              (toString proton-ge-bin.steamcompattool);

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
