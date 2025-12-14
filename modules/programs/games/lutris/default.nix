{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# multi launcher for linux

mkIf false {
  persist.user.dirs = [ ".config/lutris" ];

  hm.programs.lutris = {
    enable = true;

    defaultWinePackage = pkgs.proton-ge-bin;
    steamPackage = config.programs.steam.package;

    protonPackages = attrValues {
      inherit (pkgs)
        proton-ge-bin
        ;
    };
  };
}
