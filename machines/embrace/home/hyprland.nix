{
  module.wm.hyprland = {
    autostart = [
      "mako"
      "waybar"
    ]; # autostart
    binds =
      let
        # regex
        mk =
          mod: sub: key: cmd:
          "${toString mod}  ${toString sub}, ${key}, exec, ${cmd}";
        # mod & nomod
        m = (mk "$m" null);
        s = (mk "$m" "$s");
      in
      [
        # menus
        (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")
        (s "$tb" "tofi-drun -c ~/.config/tofi/horizontal | xargs hyprctl dispatch exec -- ")
        (s "$sp" "killall -SIGUSR1 .waybar-wrapped")
        (s "$sp" "killall -SIGUSR1 .waybar-wrapped")

        # programs
        (m "$rt" "kitty")
        (s "$rt" "kitty --class=termfloat")

        (m "V" "telegram-desktop")

        (m "B" "qutebrowser")

        (m "N" "yazi")
        (s "N" "nemo")

        (m "M" "spotify")
        (s "M" "kitty --class=ani anicli-ru -q 1080")
      ];
  };
}
