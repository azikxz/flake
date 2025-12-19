{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# use 'fprint-enroll' and 'sudo fprint-enroll'

mkIf (mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/fprint" ];

  services.fprintd = {
    enable = true;

    package = pkgs._2411.fprintd-tod;

    tod = {
      enable = true;

      driver = pkgs._2411.libfprint-2-tod1-vfs0090;
    };
  };
}
