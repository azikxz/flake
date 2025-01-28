{
  pkgs,
  lib,
  ...
}:
with lib;
{
  module.wm.hyprland = {
    autostart = [
      "mako"
      "waybar"
    ]; # autostart
    binds =
      let
        inherit (pkgs) grimblast;
        pic = "$(xdg-user-dir PICTURES)/$(date +'scr_%d-%m-%y|%H:%M:%S.png')";
        c = "--class";
        # regex
        mk =
          mod: sub: key: cmd:
          "${toString mod}  ${toString sub}, ${key}, exec, ${cmd}";
        # mod & nomod
        mod = (mk "$m");
        m = (mod null);
        s = (mod "$s");
        a = (mod "$a");
      in
      [
        # menus
        (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")
        (s "$sp" "killall -SIGUSR1 .waybar-wrapped")

        # programs
        (m "$rt" "kitty")
        (s "$rt" "kitty ${c}=termfloat")

        (m "V" "telegram-desktop")

        (m "B" "qutebrowser")

        (m "N" "yazi")
        (s "N" "nemo")

        (m "M" "spotify")
        (s "M" "kitty ${c}=ani anicli-ru -q 1080")

        # screenshot
        (mk null null "$PR" "${getExe grimblast} copysave area   ${pic}")
        (mk null "$s" "$PR" "${getExe grimblast} copysave output ${pic}")
      ];
  };
}
