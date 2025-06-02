{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  security = {
    polkit.enable = true;
    soteria.enable = true;
  };

  systemd.user.services.soteria = {
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    script = getExe config.security.soteria.package;
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
