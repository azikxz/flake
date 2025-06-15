{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [ ".local/state/syncthing" ];

  hm.services.syncthing = {
    enable = true;

    settings = {
      folders =
        with sync;
        let
          devices = (attrNames config.hm.services.syncthing.settings.devices);
        in
        listToAttrs [
          (mkFolder "passwords" (dirOf "~/Sync/passwords/db.kdbx") devices)
        ];

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
