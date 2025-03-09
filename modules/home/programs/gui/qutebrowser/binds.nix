{
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) x;
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
    # keepassxc
    ",p" = "spawn --userscript qute-keepass -p ${x.path.pass}";
    # transPopup
    ",t" = "spawn --userscript ${pkgs.xpk.qTransPag}/exe -s en -t ru";
    ",T" = "spawn --userscript ${pkgs.xpk.qTransPop}/exe --target_lang ru";
    # tabs
    ",b" = "config-cycle tabs.show always switching";
    ",s" = "config-cycle statusbar.show in-mode always";
  };
}
