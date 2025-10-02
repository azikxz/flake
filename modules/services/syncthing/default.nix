{
  lib,
  config,
  ...
}:

with lib;
# http://localhost:8384

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/state/syncthing" ];

  hm.services.syncthing = {
    enable = true;

    settings = {
      folders =
        let
          inherit (lib.sync)
            mkFolder
            ;

          devices = attrNames config.hm.services.syncthing.settings.devices;
        in
        with config.hm.xdg;
        listToAttrs (
          (with userDirs; [
            (mkFolder "temporal" "${desktop}/temp" devices)

            (mkFolder "passwords" "${documents}/passwords" devices)

            (mkFolder "notes" "${documents}/notes" devices)

            (mkFolder "video" "${videos}/filmed" devices)
          ])
          ++ [
            (mkFolder "mindustry" "${dataHome}/Mindustry/saves" devices)
          ]
        );

      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
    };
  };

  networking.firewall = rec {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = allowedTCPPorts ++ [ 21027 ];

    interfaces = {
      "tailscale0".allowedTCPPorts = [ 8384 ];
    };
  };
}
