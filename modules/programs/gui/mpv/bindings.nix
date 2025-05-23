let
  mk = cmd: desc: ''${cmd}; show-text "${desc}"'';
in

{
  WHEEL_UP = "add volume 2";
  WHEEL_DOWN = "add volume -2";
  "Shift+WHEEL_UP" = "add volume 5";
  "Shift+WHEEL_DOWN" = "add volume -5";

  RIGHT = "seek 5";
  l = "seek 5";
  "д" = "seek 5";

  LEFT = "seek -5";
  h = "seek -5";
  "р" = "seek -5";

  UP = "add volume 2";
  k = "add volume 2";
  "л" = "add volume 2";

  DOWN = "add volume -2";
  j = "add volume -2";
  "о" = "add volume -2";

  "Shift+RIGHT" = "seek 10";
  "Shift+LEFT" = "seek -10";

  "Shift+UP" = "add volume 5";
  "Shift+DOWN" = "add volume -5";

  q = "quit";
  "й" = "quit";
  Q = "quit-watch-later";

  SPACE = mk "cycle pause" "Paused";
  p = mk "cycle pause" "Paused";
  "з" = mk "cycle pause" "Paused";

  m = mk "cycle mute" "Muted";
  "ь" = mk "cycle mute" "Muted";

  o = "show-progress";
  "щ" = "show-progress";

  f = "cycle fullscreen";
  "а" = "cycle fullscreen";
  ESC = "set fullscreen no";
}
