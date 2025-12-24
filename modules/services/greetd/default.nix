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

mkIf (mac' "isoXtended") {
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    greeterManagesPlymouth = true;

    settings = {
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
    }
    // (optionalAttrs (mac "pcRyazenka") {
      initial_session = {
        command =
          if config.programs.uwsm.enable then
            "uwsm start niri-uwsm.desktop"
          else
            getExe' config.programs.niri.package "niri-session";
        user = system.userName;
      };
    });
  };
}
