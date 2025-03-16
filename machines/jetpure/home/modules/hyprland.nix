{
  pkgs,
  config,
  ...
}:

let
  tg = config.module.programs.gui.telegram.package;
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
      # menus
      (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")
      (s "$tb" "wlogout -sc 12 -r 12")

      # programs
      (m "$rt" "kitty")
      (s "$rt" "kitty --class=termfloat")

      (m "V" (if (tg == pkgs.ayugram-desktop) then "ayugram-desktop" else "telegram-desktop"))
      (s "V" "vesktop")

      (m "B" "qutebrowser")
      (s "B" "keepassxc")

      (m "N" "yazi")
      (s "N" "kitty --class=termfloat yazi")

      (m "M" "spotify")
      (s "M" "kitty --class=ani anicli-ru -q 1080")
    ];
  };
}
