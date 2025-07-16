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
    savePath = mkPath "${config.hm.xdg.userDirs.download}/Torrents";

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
            "${cfg.savePath}/"."d" = {
              inherit (cfg)
                user
                group
                mode
                ;
            };

            "${cfg.profileDir}/"."d" = base;

            "${cfg.profileDir}/qBittorrent/"."d" = base;

            "${cfg.profileDir}/qBittorrent/config/"."d" = base;

            "${cfg.profileDir}/qBittorrent/config/qBittorrent.conf"."L+" = base // {
              argument = "${pkgs.writeText "qBittorrent.conf" (gendeepINI {
                LegalNotice.Accepted = true;

                BitTorrent.Session = {
                  TempPathEnabled = true;
                  DefaultSavePath = cfg.savePath;
                  QueueingSystemEnabled = true;
                  IgnoreSlowTorrentsForQueueing = true;
                  SlowTorrentsDownloadRate = 40; # kbps
                  SlowTorrentsUploadRate = 40; # kbps
                  GlobalMaxInactiveSeedingMinutes = 43800;
                  GlobalMaxSeedingMinutes = 10080;
                  GlobalMaxRatio = 2;
                  MaxActiveCheckingTorrents = 2;
                  MaxActiveDownloads = 5;
                  MaxActiveUploads = 15;
                  MaxActiveTorrents = 20;
                  MaxConnections = 600;
                  MaxUploads = 200;
                };

                Preferences.WebUI = {
                  Enabled = true;
                  AuthSubnetWhitelistEnabled = true;
                  LocalHostAuth = false;
                  UseUPnP = false;
                  Username = "pirate";
                  Password_PBKDF2 = "@ByteArray(HsNaxVT2CfZtscvsC7dTtA==:+vOvJK4/ZWgvtSuNwFPXsro2CzGwa2uuDq5lW8faKBNxV4UqkHhTeiC9kANmeYevRg0xtJmhumedqGgCEttQLw==)"; # gen with qbithash
                  HTTPS = {
                    Enabled = true;
                    CertificatePath = toString (
                      pkgs.writeText "server.crt" ''
                        -----BEGIN CERTIFICATE-----
                        MIID3zCCAsegAwIBAgIUG/VcAbknZggpiOtC77RUVtbRpQIwDQYJKoZIhvcNAQEL
                        BQAwfzELMAkGA1UEBhMCUlUxDTALBgNVBAgMBEFtdXIxDjAMBgNVBAcMBVR5bmRh
                        MQ8wDQYDVQQKDAZCQU1pR1QxDzANBgNVBAsMBkRWR1VQUzEOMAwGA1UEAwwFQXpp
                        a3gxHzAdBgkqhkiG9w0BCQEWEHhmYWx3YUBnbWFpbC5jb20wHhcNMjUwNzE2MTAz
                        NDMyWhcNMjUwODE1MTAzNDMyWjB/MQswCQYDVQQGEwJSVTENMAsGA1UECAwEQW11
                        cjEOMAwGA1UEBwwFVHluZGExDzANBgNVBAoMBkJBTWlHVDEPMA0GA1UECwwGRFZH
                        VVBTMQ4wDAYDVQQDDAVBemlreDEfMB0GCSqGSIb3DQEJARYQeGZhbHdhQGdtYWls
                        LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKy2LfQzeykzyfBY
                        dJEJPec9gKeyMT0J8M/eEQY5OqHZgBwqtbJwxM+gWeTZbnwPZPHyZ1zo2bR3zfTm
                        5TJ+TV6walyMgvO2CGe0pcVSu8OultXeQVtwLjUbsOn18w6UPENRESIQWPK4zNM0
                        nES/F2xZMYySprJTVmRyH4A0LUd9xPvDSyaaPHL7LgHtW7Ui0lo7VMiS5yjni5em
                        2EV9pTgkAC4GKKU5rhnXyRc2mbpBdyuJxAxntv2VJjhv+NU/Dgj4rZNFWA4+ro3/
                        /vPtlA77wKmKKuJPilmYCHSa/B2VTAey69qzr2a3toeJiIWkMG2Ckl6yxUOHH7Xf
                        gYWeFTMCAwEAAaNTMFEwHQYDVR0OBBYEFJu5opje9MKZenwutZlSYDoznoKnMB8G
                        A1UdIwQYMBaAFJu5opje9MKZenwutZlSYDoznoKnMA8GA1UdEwEB/wQFMAMBAf8w
                        DQYJKoZIhvcNAQELBQADggEBAJo/Yog9vcgo/mA+8ui0b3dEIE9s6ymOxVJxExvP
                        EXJUxtNZyBcc0ZijHkhMvXYJOlqV+8n0ihLK9gZZi98tUmfsXYJpTcBUgM+VCJpy
                        efGrFcwIgjie4krgE496RgIykibPGdtXY1xDu32YrT5+r/FZnSgFBVT0oiugArhH
                        WhKL1zgC1x1g6Y/OTe4deuu6NZpiIc4Fy4plNUablwzyqv2Gq2BBHBrU/lGTYzms
                        irsOSOhVsZ5zZtWv9R/GInJsqrttlhr7LcxK+wiKasg46BLrb9eVlJTlRV5SkieK
                        rkS6aKaVtHvbwlRN958yrEpQqbT6BU9ELkK3qfaQLPqdYig=
                        -----END CERTIFICATE-----
                      ''
                    );
                    KeyPath = toString (
                      pkgs.writeText "server.key" ''
                        -----BEGIN PRIVATE KEY-----
                        MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCsti30M3spM8nw
                        WHSRCT3nPYCnsjE9CfDP3hEGOTqh2YAcKrWycMTPoFnk2W58D2Tx8mdc6Nm0d830
                        5uUyfk1esGpcjILztghntKXFUrvDrpbV3kFbcC41G7Dp9fMOlDxDUREiEFjyuMzT
                        NJxEvxdsWTGMkqayU1Zkch+ANC1HfcT7w0smmjxy+y4B7Vu1ItJaO1TIkuco54uX
                        pthFfaU4JAAuBiilOa4Z18kXNpm6QXcricQMZ7b9lSY4b/jVPw4I+K2TRVgOPq6N
                        //7z7ZQO+8CpiiriT4pZmAh0mvwdlUwHsuvas69mt7aHiYiFpDBtgpJessVDhx+1
                        34GFnhUzAgMBAAECggEARPXC2IAbu4JVrbUr6eM2R9fbQFoaZeRLtjvVMVZ1bj1R
                        dS2qedKkCsDcU89rWXauGBrxIXxJvNCfOBtfRW9/xgCLn2NtQBEdPwc2r1iO5x2V
                        VVSWZQOgN41UcL5G67nNbBV40VCUq2mVQvl9McfY+uaMLbQ6gfZbhuS4ZjCvKZ1J
                        ivZp3XF6vlDWmX8xDPwgWXuDOqIIHHkDcjG+rtg42A9QPHaMkdx1RSCOFkvjg8Qc
                        pxLiVyVaqRcl4/iSNir4JRw2VYYfqqcdvviYEDYynMW1XwhaHgS0ig/NrzHYCRYF
                        8DgbHEhfeYpefesQ/e6bcoEr60VkQ15TK2iwpjmWNQKBgQDss8tFcnRY/JR87z9R
                        bS+OTIYXkcGGT8aJXPUoqbiVNwzhjKGrwigUGVEAMFx/2nACfZbE80bc87rz0alQ
                        lEVn5hB5z/V8Lz+7cqyR0Squ1xUaSLPSFadHJWewaNUs3j8gqq+72NtoqaHsx+Zv
                        kycDDTbfVA7FeeAbuKKrUILz5QKBgQC6ytaSEEq63pIytfeZWkl4s0xs7g7m6oWp
                        yGpeQEimDNudox8RAmJf6zX1mPG6qxN7n6pcy7epGBLwcAQ8QClS8JqFErZUk9bR
                        +u99x16ifOm0q0eiT6Zzuv8677HhCymgZsLKsHgMBWiNkxvOtT2gkkbLPF1/KVcf
                        DUxLJCADNwKBgQDovm18jus6aLm1EybmcP8W48XiPQ7We3DTtpTVc/Usu6Gt0jNS
                        CSqRgMc18Vey293RhR4P8MpYDkxg3GKo+fI5FG5U6JgQkQEQ1tQ62TooCxMT8jLm
                        uyXtfikzvBEI+kuGWm9LvRMZGds/UNwUD9SHWqH+/M89e/ZSK72/x/3LxQKBgQCI
                        f39LH3Ksmca2HflAbBTyifuYQmJLZiekyVrJYypzhUPbLv+du2NN+qDkxw4mPauw
                        FB43T3r3qyrz3reJm81W2ZHhGqp4pcw+h6QJAu7pyGQz7VIcjx3wxj6Kv+v5quGR
                        YGaKHWisSCt+AXk5lYHiW+I10/fy26/ZditBYbWvAwKBgFB4wlwBiP2pVXFOF8Ks
                        IKXJ3XPnfTgyoZdR3JayfVKkz9EnZG818RGckynv3fqPB2TbFnLZxrP89FpPpgrX
                        i7EkkRN2IR0THN9G1+NS6JXZhE7OphHcryiM07d8goB0LoFojGd1Ptd6J6qtiYjN
                        Oqhz6VE6au/X3k6XbycTqQdp
                        -----END PRIVATE KEY-----
                      ''
                    );
                  };
                };

                RSS.Session = {
                  EnableProcessing = true;
                  MaxArticlesPerFeed = 2000;
                  RefreshInterval = 10;
                };
              })}";
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

          User = cfg.user;
          Group = cfg.group;

          WorkingDirectory = cfg.profileDir;
          StateDirectory = "qBittorrent";
          TimeoutStopSec = 1800;

          ProcSubset = "pid";
          RemoveIPC = true;
          NoNewPrivileges = true;

          PrivateTmp = false;
          PrivateNetwork = false;
          PrivateDevices = true;
          PrivateUsers = true;

          ProtectHome = "yes";
          ProtectProc = "invisible";
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
      [ cfg.webuiPort ]
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
