{
  pkgs,
  lib,
  ...
}:
let
  # MODIFIERS
  m = "Mod4";
  s = "Shift";
  a = "Alt";
  # BUTTUONS
  rt = "Return";
  tb = "Tab";
  sp = "Space";
  pr = "Print";
  # DISPATCHERS
  ex = "exec";
  ws = "workspace";
  mv = "move";
  cn = "container";
  nm = "number";
  # PROGRAMS
  pic = "$(xdg-user-dir PICTURES)/$(date +'scr_%d-%m-%y|%H:%M:%S.png')";
  inherit (lib) mkForce;
  inherit (pkgs) grimblast;
in
mkForce {
  "${m}+q" = "kill";
  "${m}+f" = "fullscreen";
  "${m}+${s}+f" = "move position center";
  "${m}+${sp}" = "floating toggle";
  "${m}+${s}+${sp}" = "${ex} killall -SIGUSR1 waybar";
  "${m}+${s}+${sp}" = "move position center";

  "${m}+${rt}" = "${ex} kitty";
  "${m}+${rt}" = "${ex} kitty ----class=termfloat";

  "${pr}" = "${grimblast}/bin/grimblast copysave area";
  "${pr}+${s}" = "${grimblast}/bin/grimblast copysave output ${pic}";
  "${pr}+${a}" = "${grimblast}/bin/grimblast copysave active ${pic}";

  "${m}+g" = "layout tabbed";
  "${m}+${s}+g" = "layout toggle split";

  "${m}+p" = "move scratchpad";
  "${m}+${s}+p" = "scratchpad show";

  "${m}+Home" = "exit";
  "${m}+${s}+Home" = "reload";

  "${m}+1" = "${ws} ${nm} 1";
  "${m}+2" = "${ws} ${nm} 2";
  "${m}+3" = "${ws} ${nm} 3";
  "${m}+4" = "${ws} ${nm} 4";
  "${m}+5" = "${ws} ${nm} 5";
  "${m}+6" = "${ws} ${nm} 6";
  "${m}+7" = "${ws} ${nm} 7";
  "${m}+8" = "${ws} ${nm} 8";
  "${m}+9" = "${ws} ${nm} 9";
  "${m}+0" = "${ws} ${nm} 10";

  "${m}+${s}+1" = "${mv} ${cn} to ${ws} ${nm} 1";
  "${m}+${s}+2" = "${mv} ${cn} to ${ws} ${nm} 2";
  "${m}+${s}+3" = "${mv} ${cn} to ${ws} ${nm} 3";
  "${m}+${s}+4" = "${mv} ${cn} to ${ws} ${nm} 4";
  "${m}+${s}+5" = "${mv} ${cn} to ${ws} ${nm} 5";
  "${m}+${s}+6" = "${mv} ${cn} to ${ws} ${nm} 6";
  "${m}+${s}+7" = "${mv} ${cn} to ${ws} ${nm} 7";
  "${m}+${s}+8" = "${mv} ${cn} to ${ws} ${nm} 8";
  "${m}+${s}+9" = "${mv} ${cn} to ${ws} ${nm} 9";
  "${m}+${s}+0" = "${mv} ${cn} to ${ws} ${nm} 10";

  # "${m}+h" = "focus left";
  # "${m}+j" = "focus down";
  # "${m}+k" = "focus up";
  # "${m}+l" = "focus right";

  "${m}+${s}+h" = "move left";
  "${m}+${s}+j" = "move down";
  "${m}+${s}+k" = "move up";
  "${m}+${s}+l" = "move right";

  "${m}+${a}+h" = "move workspace to output left";
  "${m}+${a}+j" = "move workspace to output down";
  "${m}+${a}+k" = "move workspace to output up";
  "${m}+${a}+l" = "move workspace to output right";
}
