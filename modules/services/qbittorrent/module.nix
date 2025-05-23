{
  pkgs,
  lib,
  config,
  utils,
  ...
}:

with lib;

let
  cfg = config.services.qbittorrent;
  inherit (builtins)
    concatStringsSep
    isAttrs
    isString
    ;
  inherit (lib.generators)
    toINI
    mkKeyValueDefault
    mkValueStringDefault
    ;
  gendeepINI = toINI {
    mkKeyValue =
      let
        sep = "=";
      in
      k: v:
      if isAttrs v then
        concatStringsSep "\n" (
          collect isString (
            mapAttrsRecursive (
              path: value:
              "${escape [ sep ] (concatStringsSep "\\" ([ k ] ++ path))}${sep}${mkValueStringDefault { } value}"
            ) v
          )
        )
      else
        mkKeyValueDefault { } sep k v;
  };
in

{
  options.services.qbittorrent = {
    enable = mkBool false;
    package = mkPkg pkgs.qbittorrent-nox;
    user = mkStr "qbittorrent";
    group = mkStr "qbittorrent";
    mode = mkStr "0775";
    profileDir = mkPath "/var/lib/qBittorrent/";
    webuiPort = mkPort 8080;
    torrentingPort = mkNull.port 6881;
    openFirewall = mkBool false;
    serverConfig = mkUns { };
  };

  config = mkIf cfg.enable {
    systemd = {
      tmpfiles.settings = {
        qbittorrent =
          let
            base = {
              inherit (cfg)
                user
                group
                mode
                ;
            };
          in
          {
            "${cfg.profileDir}/"."d" = base;
            "${cfg.profileDir}/qBittorrent/"."d" = base;
            "${cfg.profileDir}/qBittorrent/config/"."d" = base;
            "${cfg.profileDir}/qBittorrent/config/qBittorrent.conf"."L+" = base // {
              argument = "${pkgs.writeText "qBittorrent.conf" (gendeepINI cfg.serverConfig)}";
            };
          };
      };
      services.qbittorrent = {
        wants = [
          "network-online.target"
        ];
        after = [
          "local-fs.target"
          "network-online.target"
          "nss-lookup.target"
        ];
        wantedBy = [
          "multi-user.target"
        ];
        serviceConfig = {
          Type = "simple";
          ExecStart = utils.escapeSystemdExecArgs (
            [
              (getExe cfg.package)
              "--profile=${cfg.profileDir}"
              "--webui-port=${toString cfg.webuiPort}"
            ]
            ++ (optional (cfg.torrentingPort != null) "--torrenting-port=${toString cfg.torrentingPort}")
          );
          StateDirectory = "qBittorrent";
          TimeoutStopSec = 1800;
          PrivateTmp = false;
          PrivateNetwork = false;
          RemoveIPC = true;
          NoNewPrivileges = true;
          PrivateDevices = true;
          PrivateUsers = true;
          ProtectHome = "yes";
          ProtectProc = "invisible";
          ProcSubset = "pid";
          ProtectSystem = "full";
          ProtectClock = true;
          ProtectHostname = true;
          ProtectKernelLogs = true;
          ProtectKernelModules = true;
          ProtectKernelTunables = true;
          ProtectControlGroups = true;
          RestrictAddressFamilies = [
            "AF_INET"
            "AF_INET6"
            "AF_NETLINK"
          ];
          RestrictNamespaces = true;
          RestrictRealtime = true;
          RestrictSUIDSGID = true;
          LockPersonality = true;
          MemoryDenyWriteExecute = true;
          SystemCallArchitectures = "native";
          CapabilityBoundingSet = "";
          SystemCallFilter = [ "@system-service" ];
        };
      };
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall (
      [
        cfg.webuiPort
      ]
      ++ optional (cfg.torrentingPort != null) [
        cfg.torrentingPort
      ]
    );
    users = {
      groups.${cfg.group} = { };
      users.${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
      };
    };
  };
}
