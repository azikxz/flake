{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  mk = command: {
    user = system.userName;
    inherit
      command
      ;
  };
in
# INFO:
# best display manager

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  services.greetd = {
    enable = true;

    settings = {
      initial_session = mk (getExe config.programs.hyprland.package);

      default_session = mk (
        concatStringsSep " " [
          (getExe pkgs.tuigreet)
          "--asterisks"
          "--remember"
          "--remember-session"
          "--time"
          "--theme"
          (concatStringsSep ";" [
            "border=magenta"
            "text=cyan"
            "prompt=green"
            "time=red"
            "action=blue"
            "button=yellow"
            "container=black"
            "input=red"
          ])
        ]
      );
    };
  };
}
