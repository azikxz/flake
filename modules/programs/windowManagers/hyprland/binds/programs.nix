{
  pkgs,
  lib,
  config,
  ...
}:

let
  mk =
    mod: sub: key: cmd:
    "${toString mod}  ${toString sub}, ${key}, exec, ${cmd}";

  m = mk "$m" null;
  s = mk "$m" "$s";
in

(
  if config.hm.programs.kitty.enable then
    [
      (m "return" "kitty")
      (s "return" "kitty --class=termfloat")
    ]
  else if config.hm.programs.foot.enable then
    [
      (m "return" "foot")
      (s "return" "foot -a termfloat")
    ]
  else
    [ (m "return" (lib.getExe pkgs.foot)) ]
)
++ [
  (m "tab" "tofi-drun | xargs hyprctl dispatch exec -- ")
  (s "tab" (lib.getExe pkgs.clapboard))

  (s "space" "killall -SIGUSR1 .waybar-wrapped")

  (m "v" "AyuGram")
  (s "v" "equibop")

  (m "b" "qutebrowser")
  (s "b" "keepassxc")

  (m "n" "kitty yazi")
  (s "n" "kitty --class=termfloat yazi")

  (m "m" "spotify")
  (s "m" "obsidian")
]
