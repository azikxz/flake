{
  pkgs,
  lib,
  ...
}:

{
  normal = {
    # tabs
    "<Alt-j>" = "tab-move +";
    "<Alt-k>" = "tab-move -";
    "gp" = "tab-pin ;; " + "tab-move";

    # mpv
    ",h" = "open qute://start/";

    # mpv
    ",m" = "spawn mpv {url} ;; " + "message-info 'Video will be open in MPV'";
    ",M" = "hint links spawn mpv {hint-url} ;; " + "message-info 'Video will be open in MPV'";

    # copy i,age url
    "yi" = "hint images yank";
    "yI" = "hint images yank -s";

    # keepassxc
    ",p" = "spawn --userscript qute-keepass -p " + lib.paths.passwords;

    # transPopup
    ",t" = "spawn --userscript ${pkgs."qutebrowser/page"}/exe -s en -t ru";
    ",T" = "spawn --userscript ${pkgs."qutebrowser/popup"}/exe --target_lang ru";
  };
}
