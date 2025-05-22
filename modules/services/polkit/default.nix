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

  systemd.user.services.polkit-soteria = {
    description = "Soteria, Polkit authentication agent for any desktop environment";

    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    script = lib.getExe config.security.soteria.package;
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
