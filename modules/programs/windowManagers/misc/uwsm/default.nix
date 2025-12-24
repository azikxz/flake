{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# wm / de manager, cool

mkIf false {
  programs.uwsm = {
    enable = true;

    waylandCompositors.niri = {
      prettyName = "Niri The Goat";
      comment = "Niri compositor managed by UWSM";
      binPath = getExe' config.programs.niri.package "niri-session";
    };
  };
}
