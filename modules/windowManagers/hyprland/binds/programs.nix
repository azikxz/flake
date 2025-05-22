let
  mk =
    mod: sub: key: cmd:
    "${toString mod}  ${toString sub}, ${key}, exec, ${cmd}";

  m = mk "$m" null;
  s = mk "$m" "$s";
in

[
  (m "return" "kitty")
  (s "return" "kitty --class=termfloat")

  (m "tab" "tofi-drun | xargs hyprctl dispatch exec -- ")

  (m "v" "telegram-desktop")
  (s "v" "vesktop")

  (m "b" "qutebrowser")
  (s "b" "keepassxc")

  (m "n" "kitty yazi")
  (s "n" "kitty --class=termfloat yazi")

  (m "m" "spotify")
  (s "m" "kitty --class=ani anicli-ru -q 1080")
]
