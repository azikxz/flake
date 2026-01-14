{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.hm.services.syncthing.settings)
    devices
    ;

  shared = list: attrNames (removeAttrs devices list);
in
# INFO:
# i waited 7 years...finally

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/hytale-launcher" ];

  hmPackages = [ pkgs.hytale ];

  hm.services.syncthing.settings.folders = listToAttrs [
    (sync.mkFolder "hytale-saves" "${config.hm.xdg.dataHome}/Hytale/UserData/Saves" (shared [ ]))
  ];
}
