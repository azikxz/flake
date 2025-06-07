{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf
  (config.programs.steam.enable && versionAtLeast config.boot.kernelPackages.kernel.version "6.14")
  {
    boot.kernelModules = [ "ntsync" ];

    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "ntsync-udev-rules";
        text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
        destination = "/etc/udev/rules.d/70-ntsync.rules";
      })
    ];
  }
