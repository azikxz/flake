{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
