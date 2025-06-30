{
  lib,
  ...
}:

{
  defaultApplications =
    (type: list: (lib.genAttrs list (none: (type + ".desktop"))))
      "io.github.tdesktop_x64.TDesktop.desktop"
      [
        "application/x-xdg-protocol-tg"
        "x-scheme-handler/tg"
      ];
}
