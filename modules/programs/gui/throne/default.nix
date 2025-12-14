{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.programs.throne;
in
# INFO:
# new gen nekoray

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/Throne" ];

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  hm.systemd.user.services.throne-tray = {
    Unit = {
      Description = cfg.package.meta.description;
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = concatStringsSep " " [
        (getExe cfg.package)
        "-tray"
        "-appdata"
      ];

      Type = "simple";
      KillMode = "process";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
