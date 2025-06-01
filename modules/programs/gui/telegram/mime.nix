{
  package,
  pkgs,
  lib,
  ...
}:

let
  mk = type: list: (lib.genAttrs list (n: (type + ".desktop")));

  client =
    if
      lib.elem package [
        pkgs._64gram
        pkgs._24._64gram
        pkgs._25._64gram
      ]
    then
      "io.github.tdesktop_x64.TDesktop.desktop"
    else if package == (pkgs.ayugram-desktop) then
      "com.ayugram.desktop.desktop"
    else
      "org.telegram.desktop.desktop";
in

{
  defaultApplications = mk client [
    "application/x-xdg-protocol-tg"
    "x-scheme-handler/tg"
  ];
}
