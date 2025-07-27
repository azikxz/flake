{
  lib,
  config,
  ...
}:

with lib;
# WARN: i didnt yet made it for other browsers
# (only qutebrowser)

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.keepassxc = {
    enable = true;

    settings = import ./settings.nix;
  };

  systemd.user.services.keepassxc = {
    description = "Autostart for keepassxc";

    script = concatStringsSep " " [
      (getExe config.hm.programs.keepassxc.package)
      "--minimized"
      "--pw-stdin"
      "~/Documents/passwords/db.kdbx"
    ];

    postStart = "sleep 1";
    reload = "kill -SIGUSR2 $MAINPID";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
