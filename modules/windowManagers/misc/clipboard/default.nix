{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine != "isoXtended") {
  systemd.user.services.wl-clip-persist = {
    description = "Keep clipboard even after programs close";

    script = "${getExe pkgs.wl-clip-persist} -c both";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
