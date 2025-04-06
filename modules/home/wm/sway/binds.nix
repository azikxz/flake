{
  pkgs,
  lib,
  ...
}:
let
  # modifiers
  m = "Mod4";
  s = "Shift";
  a = "Alt";
  # buttuons
  rt = "Return";
  sp = "Space";
  pr = "Print";
  # dispatchers
  ex = "exec ";
  # programs
  pic = "$(xdg-user-dir PICTURES)/$(date +'scr_%d-%m-%y|%H:%M:%S.png')";
  inherit (lib) mkForce getExe;
  inherit (pkgs) grimblast;
in
mkForce {
  "${m}+q" = "kill";
  "${m}+f" = "fullscreen";

  "${m}+${sp}     " = "floating toggle";
  "${m}+${s}+${sp}" = ex + "killall -SIGUSR1 waybar";
  "${m}+${a}+${sp}" = "move position center";

  "${m}+${rt}     " = ex + "kitty";
  "${m}+${s}+${rt}" = ex + "kitty --class=termfloat";

  "${pr}     " = ex + getExe grimblast + " copysave area   " + pic;
  "${pr}+${s}" = ex + getExe grimblast + " copysave output " + pic;
  "${pr}+${a}" = ex + getExe grimblast + " copysave active " + pic;

  "${m}+g     " = "layout tabbed";
  "${m}+${s}+g" = "layout toggle split";

  "${m}+p     " = "move scratchpad";
  "${m}+${s}+p" = "scratchpad show";

  "${m}+Home     " = "exit";
  "${m}+${s}+Home" = "reload";
}
// (
  let
    ws = "workspace ";
    mv = "move ";
    cn = "container ";
    nm = "number ";
    mvcn = mv + cn;
    mvws = mv + ws;
    _2ws = ws + nm;
    _2ss = mvcn + "to" + _2ws;
    sumws = [
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "10"
    ];
  in
  (lib.genAttrs sumws (n: {
    "${m}+${n}" = _2ws + n;
  }))
  // (lib.genAttrs sumws (n: {
    "${m}+${s}+${n}" = _2ss + n;
  }))
  // {
    # "${m}+h" = "focus left";
    # "${m}+j" = "focus down";
    # "${m}+k" = "focus up";
    # "${m}+l" = "focus right";

    "${m}+${s}+h" = mv + "left";
    "${m}+${s}+j" = mv + "down";
    "${m}+${s}+k" = mv + "up";
    "${m}+${s}+l" = mv + "right";

    "${m}+${a}+h" = mvws + "to output left";
    "${m}+${a}+j" = mvws + "to output down";
    "${m}+${a}+k" = mvws + "to output up";
    "${m}+${a}+l" = mvws + "to output right";
  }
)
