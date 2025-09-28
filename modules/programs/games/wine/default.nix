{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".wine" ];

  environment = {
    systemPackages = with pkgs; [
      gaming.wine-tkg-ntsync
      winetricks
    ];

    sessionVariables = {
      WINEPREFIX =
        if (mac "pcRyazenka") then
          "/media/disks/fastBitch/UnifiedPrefix"
        else
          (config.hm.home.homeDirectory + "/.wine");
    };
  };
}
