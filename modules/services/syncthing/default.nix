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

          inherit (config.hm.services.syncthing.settings)
            devices
            ;

          # call function with args [ ] if u want exlude dir for device
          shared = list: attrNames (removeAttrs devices list);
        in

        listToAttrs (
          (with config.hm.xdg.userDirs; [
            (mkFolder "temporal" "${desktop}/temp" (shared [ ]))

            (mkFolder "passwords" "${documents}/passwords" (shared [ ]))

            (mkFolder "notes" "${documents}/notes" (shared [ ]))

            (mkFolder "video" "${videos}/filmed" (shared [ "windauser" ]))

            (mkFolder "music" "${music}" (shared [ "windauser" ]))

            (mkFolder "clipboard" "~/.cache/clapboard" (shared [
              "nothing2a"
              "windauser"
            ]))
          ])
          ++ [ ]
        );

      options = {
        relaysEnabled = true;
        urAccepted = -1;
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
