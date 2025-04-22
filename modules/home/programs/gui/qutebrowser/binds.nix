{
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) getExe getExe' x;
in

{
  normal = {
    # move tabs
    "<Alt-j>" = "tab-move +";
    "<Alt-k>" = "tab-move -";
    # mpv
    ",h" = "open qute://start/";
    # mpv
    ",m" = "spawn mpv {url} ;; " + "message-info 'Video will be open in MPV'";
    ",M" = "hint links spawn mpv {hint-url} ;; " + "message-info 'Video will be open in MPV'";
    # copy i,age url
    "yi" = "hint images yank";
    "yI" = "hint images yank -s";
    # keepassxc
    ",p" = "spawn --userscript qute-keepass -p " + x.path.pass;
    # torrent upload
    ",s" =
      "hint links spawn ${getExe pkgs."qutebrowser/torrDL"} {url} ;; "
      + "message-info 'Torrent successfuly added to QBittorrent'";
    ",S" =
      "hint links spawn ${getExe pkgs.rut2qb} --paused {url} ;; "
      + "message-info 'Torrent successfuly added to QBittorrent'";
    ",r" =
      "spawn ${getExe' pkgs.torrMagnet "torrMagnet"} {url} ;; "
      + "message-info 'Torrent successfuly added to Torrserver'";
    # transPopup
    ",t" = "spawn --userscript ${pkgs."qutebrowser/page"}/exe -s en -t ru";
    ",T" = "spawn --userscript ${pkgs."qutebrowser/popup"}/exe --target_lang ru";
  };
}
