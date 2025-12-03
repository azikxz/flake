{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# best syncronize tool
#
# http://localhost:8384

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/state/syncthing" ];

  hmPackages = [ pkgs.stc-cli ];

  hm.services.syncthing = {
    enable = true;

    cert = config.sopsnix."syncthing/cert" or null;
    key = config.sopsnix."syncthing/key" or null;

    settings = {
      folders =
        let
          inherit (lib.sync)
            mkFolder
            ;

          devices = attrNames config.hm.services.syncthing.settings.devices;
        in

        listToAttrs (
          (with config.hm.xdg.userDirs; [
            (mkFolder "temporal" "${desktop}/temp" devices)

            (mkFolder "passwords" "${documents}/passwords" devices)

            (mkFolder "notes" "${documents}/notes" devices)

            (mkFolder "video" "${videos}/filmed" devices)

            (mkFolder "video" "${music}" devices)
          ])
          ++ [ ]
        );

      options = {
        localAnnounceEnabled = true;
        localAnnouncePort = 21027;
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

  nixpkgs.overlays = [
    (
      final: prev: with prev.lib; {
        stc-cli = prev.writeShellScriptBin "stc-cli" ''
          ${getExe prev.stc-cli} \
            --homedir ${config.hm.xdg.stateHome}/syncthing "$@"
        '';
      }
    )
  ];
}
