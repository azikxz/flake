{
  config,
  ...
}:

let
  inherit (config.lib.stylix.colors) base0B base01;
  # regex
  mk = type: rule: "${rule}, ${type}";
  # titile & class
  cl = win: (mk "class:${win}");
  tl = win: (mk "title:${win}");
in

[
  (cl "firefox" "workspace 2 silent")
  (cl "org.qutebrowser.qutebrowser" "workspace 2 silent")
  (cl "zen-alpha" "workspace 2 silent")
  (cl "zen-beta" "workspace 2 silent")
  (cl "spotify" "workspace 3 silent")
  (cl "com.ayugram.desktop" "workspace 4 silent")
  (cl "io.github.tdesktop_x64.TDesktop" "workspace 4 silent")
  (cl "vesktop" "workspace 5 silent")
  (cl "anicli" "workspace 6 silent")
  (cl "org.qbittorrent.qBittorrent" "workspace 8 silent")
  (cl "steam" "workspace 10 silent")

  # term rules
  (cl "termfloat" "float")
  (cl "termfloat" "move center")
  (cl "termfloat" "size 650 430")

  # file manager
  (cl "tfm" "float")
  (cl "tfm" "move center")
  (cl "tfm" "size 800 350")

  # gram
  (tl "com.ayugram.desktop" "minsize 540 680")
  (tl "io.github.tdesktop_x64.TDesktop" "minsize 540 680")

  (tl "Media viewer" "float")
  (tl "Media viewer" "move center")
  (tl "Media viewer" "size 670 540")
  (tl "Media viewer" "noanim")
  (tl "Media viewer" "fullscreen")

  (tl "Choose Files" "float")
  (tl "Choose Files" "move center")
  (tl "Choose Files" "size 650 450")

  (cl "xdg-desktop-portal-gtk" "float")
  (cl "xdg-desktop-portal-gtk" "move center")
  (cl "xdg-desktop-portal-gtk" "size 807 570")

  (cl "mpv" "nodim")
  (cl "ani" "float")
  (cl "ani" "size 810 630")

  # (cl "mpv" "nodim")
  (cl "io.bassi.Amberol" "float")
  (cl "io.bassi.Amberol" "maxsize 360 660")
  (cl "io.bassi.Amberol" "minsize 360 660")

  # torrent
  (cl "org.qbittorrent.qBittorrent" "float")
  (cl "org.qbittorrent.qBittorrent" "size 1020 740")
  (cl "org.qbittorrent.qBittorrent" "pseudo")

  # passwords
  (cl "org.keepassxc.KeePassXC" "minsize 850 900")
  (cl "org.keepassxc.KeePassXC" "maxsize 850 900")

  # pinned
  (mk "pinned:1" "bordercolor rgb(${base0B}) rgb(${base01})")
]
++ (
  let
    no = "norounding, noborder, floating:0,";
  in
  [
    (no + "onworkspace:w[tv1]")
    (no + "onworkspace:f[1]")
  ]
)
