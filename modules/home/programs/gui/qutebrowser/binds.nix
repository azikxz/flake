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
    ",m" = "spawn mpv {url}";
    ",M" = "hint links spawn mpv {hint-url}";
    "yi" = "hint images yank";
    "yI" = "hint images yank -s";
    # keepassxc
    ",p" = "spawn --userscript qute-keepass -p " + x.path.pass;
    # torrserver upload
    ",s" = "hint links spawn ${getExe pkgs."qutebrowser/torrDL"} {url}";
    ",q" = "hint links spawn ${getExe pkgs.qbHelper} {url}";
    ",a" = "spawn ${getExe' pkgs.torrMagnet "torrMagnet"} {url}";
    # transPopup
    ",t" = "spawn --userscript ${pkgs."qutebrowser/page"}/exe -s en -t ru";
    ",T" = "spawn --userscript ${pkgs."qutebrowser/popup"}/exe --target_lang ru";
  };
}
