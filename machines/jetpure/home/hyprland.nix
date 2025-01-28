{
  pkgs,
  lib,
  ...
}:
with lib;
{
  module.wm.hyprland = {
    autostart = [ "mako" ]; # autostart
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
      in
      [
        # menus
        (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")
        (s "$tb" "wlogout -sc 12 -r 12")

        # programs
        (m "$rt" "kitty")
        (s "$rt" "kitty ${c}=termfloat")

        (m "V" "ayugram-desktop")
        (s "V" "vesktop")

        (m "B" "qutebrowser")
        (s "B" "secrets")

        (m "N" "yazi")
        (s "N" "kitty ${c}=termfloat yazi")

        (m "M" "spotify")
        (s "M" "kitty ${c}=ani anicli-ru -q 1080")

        (m "Z" "bottles")
        (s "Z" "prismlauncher")

        # screenshot
        (mk null null "$PR" "${getExe grimblast} copysave area   ${pic}")
        (mk null "$s" "$PR" "${getExe grimblast} copysave output ${pic}")
      ];
  };
}
