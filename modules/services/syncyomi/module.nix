{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib)
    types
    ;

  cfg = config.services.syncyomi;
  tomlFormat = pkgs.formats.toml { };
in

{
  options.services.syncyomi = {
    enable = lib.mkEnableOption "the SyncYomi server";

    package = lib.mkPackageOption pkgs "syncyomi" { };

    dataDir = lib.mkOption {
      type = types.path;
      default = "/var/lib/syncyomi";
      example = "/srv/syncyomi";
      description = ''
        State directory where `SyncYomi` stores its data.
        If left as default, systemd will manage it via `StateDirectory`.
      '';
    };

    configDir = lib.mkOption {
      type = types.path;
      default = "${cfg.dataDir}/config";
      description = "Directory passed to `--config` (`SyncYomi` writes files here).";
    };

    config = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      apply =
        conf:
        lib.mkMerge [
          {
            checkForUpdates = false;
            server = {
              inherit (cfg)
                port
                host
                ;
            };
          }
          conf
        ];
      description = ''
        Full declarative configuration for SyncYomi.
        Written once to `${cfg.configDir}/config.toml` if it does not exist.

        The `server.port` is automatically set from `services.syncyomi.port`
        unless overridden here.
      '';
    };

    user = lib.mkOption {
      type = types.str;
      default = "syncyomi";
      description = "User the service runs as.";
    };

    group = lib.mkOption {
      type = types.str;
      default = "syncyomi";
      description = "Group the service runs as.";
    };

    port = lib.mkOption {
      type = types.port;
      default = 8282;
      description = "TCP port to open in the firewall (if `openFirewall = true`).";
    };

    host = lib.mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "IP address for accessing.";
    };

    openFirewall = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Open the firewall for the configured port.";
    };

    extraArgs = lib.mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "--log-level=debug" ];
      description = "Extra command-line arguments passed to `SyncYomi`.";
    };

    environment = lib.mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Extra environment variables for the service.";
    };
  };

  config = lib.mkIf cfg.enable {
    # NOTE: Create dataDir + configDir with correct ownership & perms
    systemd.tmpfiles.rules = [
      "d '${cfg.dataDir}' 0750 ${cfg.user} ${cfg.group} -"
      "d '${cfg.configDir}' 0750 ${cfg.user} ${cfg.group} -"
      "f '${cfg.configDir}/config.toml' 0640 ${cfg.user} ${cfg.group} -"
    ];

    # NOTE: Open firewall if requested
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.port ];

    systemd.services.syncyomi = {
      description = "Synchronize Tachiyomi across multiple devices";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;

        StateDirectory = lib.mkIf (cfg.dataDir == "/var/lib/syncyomi") "syncyomi";
        WorkingDirectory = cfg.dataDir;

        ExecStartPre = pkgs.writeShellScript "syncyomi-config-toml-generation" ''
          set -eu

          CONFIG_FILE=${lib.escapeShellArg "${cfg.configDir}/config.toml"}

          if [ ! -e "$CONFIG_FILE" ]; then
            echo "Generating initial \`SyncYomi\` config at $CONFIG_FILE"

            install -m0640 -o ${cfg.user} -g ${cfg.group} \
              ${lib.escapeShellArg (tomlFormat.generate "syncyomi-initial-config.toml" cfg.config)} \
              "$CONFIG_FILE"

            SESSION_SECRET=$(${lib.getExe' pkgs.util-linux "uuidgen"} | tr -d '\n')
            echo "sessionSecret = \"$SESSION_SECRET\"" >> "$CONFIG_FILE"

            chown ${cfg.user}:${cfg.group} "$CONFIG_FILE"
          fi
        '';

        ExecStart = ''
          ${lib.getExe cfg.package} \
            --config=${lib.escapeShellArg cfg.configDir} \
            ${lib.escapeShellArgs cfg.extraArgs}
        '';

        Restart = "on-failure";
        RestartSec = 5;

        AmbientCapabilities = "";
        CapabilityBoundingSet = "";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        ReadWritePaths = [ cfg.dataDir ];
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
      };

      environment = {
        TZ = config.time.timeZone or "UTC";
      }
      // cfg.environment;
    };
  };
}
