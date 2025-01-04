{
  programs.mpv.bindings = {
    WHEEL_UP = "add volume 2";
    WHEEL_DOWN = "add volume -2";
    "Shift+WHEEL_UP" = "add volume 5";
    "Shift+WHEEL_DOWN" = "add volume -5";

    RIGHT = "seek 5";
    l = "seek 5";
    "д" = "seek 5";

    LEFT = "seek -5";
    h = "seek -5";
    "р" = "seek -5";

    UP = "add volume 2";
    k = "add volume 2";
    "л" = "add volume 2";

    DOWN = "add volume -2";
    j = "add volume -2";
    "о" = "add volume -2";

    "Shift+RIGHT" = "seek 10";
    "Shift+LEFT" = "seek -10";

    "Shift+UP" = "add volume 5";
    "Shift+DOWN" = "add volume -5";

    q = "quit";
    "й" = "quit";
    Q = "quit-watch-later";

    SPACE = "cycle pause";
    p = "cycle pause";
    "з" = "cycle pause";

    m = "cycle mute";
    "ь" = "cycle mute";

    o = "show-progress";
    "щ" = "show-progress";

    f = "cycle fullscreen";
    "а" = "cycle fullscreen";
    ESC = "set fullscreen no";

    "y" = "script-binding quality_menu/video_formats_toggle";
    "н" = "script-binding quality_menu/video_formats_toggle";
  };
}
