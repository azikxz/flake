{
  pkgs,
  lib,
  config,
  ...
}:

let
  mk = type: list: (lib.genAttrs list (n: (type + ".desktop")));
  cfg = config.module.programs.gui.telegram;
  client =
    if
      lib.elem cfg.package [
        pkgs._64gram
        pkgs.stable._64gram
      ]
    then
      "io.github.tdesktop_x64.TDesktop.desktop"
    else if cfg.package == (pkgs.ayugram-desktop) then
      "com.ayugram.desktop.desktop"
    else
      "org.telegram.desktop.desktop";
in

{
  defaultApplications = (
    mk client [
      "application/x-xdg-protocol-tg"
      "x-scheme-handler/tg"
    ]
  );
}
