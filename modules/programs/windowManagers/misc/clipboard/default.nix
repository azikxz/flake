{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  pkg = pkgs.clapboard;

  inherit (config.hm.services.syncthing.settings)
    devices
    ;

  shared = list: attrNames (removeAttrs devices list);

  toml = pkgs.formats.toml { };
in
# INFO:
# modern clipboard with tofi frontend

mkIf (mac' "isoXtended") {
  hm = {
    services = {
      wl-clip-persist.enable = true;

      syncthing.settings.folders = listToAttrs [
        (sync.mkFolder "clipboard" "${config.hm.xdg.cacheHome}/clapboard" (shared [
          "nothing2a"
          "windauser"
        ]))
      ];
    };

    systemd.user.services.clapboard = {
      Unit = {
        Description = pkg.meta.description;
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = concatStringsSep " " [
          (getExe pkg)
          "-r clipboard"
        ];

        Type = "simple";
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };

    xdg.configFile = {
      "clapboard/config.toml".source = toml.generate "clapboard.toml" {
        # INFO: tofi args
        launcher = [
          "tofi"
          "--fuzzy-match=true"
          "--prompt-text=copy: "
          "--padding-left=20%"
          "--padding-right=20%"
          "--padding-top=12%"
          "--padding-bottom=12%"
          "--num-results=12"
        ];

        history_size = 48;
      };
    };
  };
}
