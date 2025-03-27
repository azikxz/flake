let
  # regex
  mk =
    mod: sub: key: cmd:
    "${toString mod}  ${toString sub}, ${key}, exec, ${cmd}";
  # mod & nomod
  m = (mk "$m" null);
  s = (mk "$m" "$s");
in

{
  module.wm.hyprland = {
    autostart = [ "mako" ];
    binds = [
      (m "$rt" "kitty")
      (s "$rt" "kitty --class=termfloat")

      (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")

      (m "V" "telegram-desktop")
      (s "V" "vesktop")

      (m "B" "qutebrowser")
      (s "B" "keepassxc")

      (m "N" "kitty yazi")
      (s "N" "kitty --class=termfloat yazi")

      (m "M" "spotify")
      (s "M" "kitty --class=ani anicli-ru -q 1080")
    ];
  };
}
