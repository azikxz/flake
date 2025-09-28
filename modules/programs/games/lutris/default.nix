{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: multi launcher for linux

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [ ".config/lutris" ];

  hm.programs.lutris = {
    enable = true;

    defaultWinePackage = pkgs.proton-ge-bin;
    steamPackage = config.programs.steam.package;

    protonPackages = attrValues { };

    winePackages = attrValues {
      inherit (pkgs.gaming)
        wine-ge
        wine-tkg-ntsync
        ;
    };
  };
}
