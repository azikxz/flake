{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.services.qbittorrent;
in
# INFO:
# best webui for qbittorrent
#
# http://localhost:8085

mkIf config.services.qbittorrent.enable {
  persist.dirs = [ "/var/lib/flood" ];

  systemd.services.flood =
    (genAttrs [
      "after"
      "wantedBy"
    ] (n: [ "qbittorrent.service" ]))
    // {
      path = with pkgs; [ mediainfo ];

      serviceConfig = {
        Type = "simple";

        User = "flood";
        Group = "flood";

        StateDirectory = [ "flood" ];
        StateDirectoryMode = mkDefault 775;

        ExecStart = concatStringsSep " " [
          (getExe (
            # WARN:
            # dont forget to delete when will update
            pkgs.flood.overrideAttrs {
              version = "4.12.5";
              src = pkgs.fetchFromGitHub {
                owner = "jesec";
                repo = "flood";
                tag = "v${version}";
                hash = "sha256-4lmP8RRHALN8XPKZEW2jfFzwPyux5H33rF3dYxJ9u/U=";
              };
            }
          ))
          "--auth none"
          "--rundir /var/lib/flood"
          "--host 0.0.0.0"
          "--port 8113"
          "--qburl http://${cfg.serverConfig.Preferences.WebUI.Address}:${toString cfg.webuiPort}"
          "--qbuser ${system.userName}"
          "--qbpass simplepassword"
        ];
      };
    };

  users = {
    groups.flood = { };

    users.flood = {
      isSystemUser = true;

      group = "flood";
    };
  };
}
