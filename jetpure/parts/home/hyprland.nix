{
  pkgs,
  lib,
  config,
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
        a = (mod "$a");
      in
      [
        # menus
        (m "$tb" "tofi-drun | xargs hyprctl dispatch exec -- ")
        (s "$tb" "wlogout")

        # programs
        (m "$rt" "kitty")
        (s "$rt" "kitty ${c}=termfloat")

        (m "V" "telegram-desktop")

        (m "B" "qutebrowser")
        (s "B" "zen")
        (a "B" "floorp")

        (m "N" "yazi")
        (s "N" "nemo")

        (m "M" "spotify")
        (s "M" "kitty ${c}=ani anicli-ru -q 1080")
        (a "M" "onlyoffice")

        (m "Z" "bottles")
        (s "Z" "prismlauncher")
        (a "Z" "qbittorrent")

        # screenshot
        (mk null null "$PR" "${getExe grimblast} copysave area   ${pic}")
        (mk null "$s" "$PR" "${getExe grimblast} copysave output ${pic}")
      ];
    rules =
      let
        inherit (config.lib.stylix.colors) base0B base01;
        # regex
        mk = type: rule: "${rule}, ${type}";
        # titile & class
        cl = win: (mk "class:^(${win})$");
        tl = win: (mk "title:^(${win})$");
      in
      [
        (cl "firefox" "workspace 2 silent")
        (cl "zen-zen-twilight" "workspace 2 silent")
        (cl "zen-alpha" "workspace 2 silent")
        (cl "zen-beta" "workspace 2 silent")
        (cl "spotify" "workspace 3 silent")
        (cl "com.ayugram" "workspace 4 silent")
        (cl "io.github.tdesktop_x64.TDesktop" "workspace 4 silent")
        (cl "vesktop" "workspace 5 silent")
        (cl "anicli" "workspace 6 silent")
        (cl "org.qbittorrent.qBittorrent" "workspace 8 silent")

        # term rules
        (cl "termfloat" "float")
        (cl "termfloat" "move center")
        (cl "termfloat" "size 650 430")

        # file manager
        (cl "tfm" "float")
        (cl "tfm" "move center")
        (cl "tfm" "size 800 350")

        # gram
        (tl "com.ayugram" "minsize 540 680")
        (tl "io.github.tdesktop_x64.TDesktop" "minsize 540 680")

        (tl "Media viewer" "float")
        (tl "Media viewer" "move center")
        (tl "Media viewer" "size 670 540")
        (tl "Media viewer" "noanim")
        (tl "Media viewer" "fullscreen")

        (tl "Choose Files" "float")
        (tl "Choose Files" "move center")
        (tl "Choose Files" "size 650 450")

        # (cl "xdg-desktop-portal-gtk" "float")
        (cl "xdg-desktop-portal-gtk" "move center")
        (cl "xdg-desktop-portal-gtk" "size 807 570")

        # (cl "mpv" "nodim")
        (cl "ani" "float")
        (cl "ani" "size 810 630")

        # torrent
        (cl "org.qbittorrent.qBittorrent" "float")
        (cl "org.qbittorrent.qBittorrent" "size 1020 740")
        (cl "org.qbittorrent.qBittorrent" "pseudo")

        # pinned
        (mk "pinned:1" "bordercolor rgb(${base0B}) rgb(${base01})")
      ];
  };
}
