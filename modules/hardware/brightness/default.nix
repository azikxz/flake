{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  systemd.services.brightness = {
    description = ''
      Sets brightness to 100
    '';

    after = [ "basic.target" ];
    wantedBy = [ "basic.target" ];

    script = concatStringsSep " " [
      (getExe pkgs.light)
      "-A"
      (toString 100)
    ];
  };
}
