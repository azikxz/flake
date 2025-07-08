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

mkIf (machine != "isoXtended") {
  services.greetd = {
    enable = true;

    settings =
      {
        initial_session = mk (getExe config.programs.hyprland.package);
      }
      // {
        default_session = mk (
          concatStringsSep " " [
            (getExe pkgs.greetd.tuigreet)
            "--cmd"
            (getExe config.programs.hyprland.package)
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

        steam_session = mk "steam-gamescope > /dev/null 2>&1";
      };
  };
}
