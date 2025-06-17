{
  pkgs,
  ...
}:

{
  normal = {
    # tabs
    "<Alt-j>" = "tab-move +";
    "<Alt-k>" = "tab-move -";
    "gp" = "tab-pin ;; " + "tab-move";

    "<Alt-t>" = "set-cmd-text -s :open -w";
    "<Alt-p>" = "open -w -- {clipboard}";

    # mpv
    "gh" = "open qute://start/";

    # mpv
    ",m" = "spawn mpv {url} ;; " + "message-info 'Video will be open in MPV'";
    ",M" = "hint links spawn mpv {hint-url} ;; " + "message-info 'Video will be open in MPV'";

    # copy i,age url
    "yi" = "hint images yank";
    "yI" = "hint images yank -s";

    # keepassxc
    ",," = "spawn --userscript qute-keepass -p ~/Documents/passwords/db.kdbx";

    # transPopup
    ",t" = "spawn --userscript ${pkgs."qutebrowser/page"}/exe -s en -t ru";
    ",T" = "spawn --userscript ${pkgs."qutebrowser/popup"}/exe --target_lang ru";
  };
}
