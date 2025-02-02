{
  x,
  ...
}:
let
  tranPopup = x.customPkgs "qute/tranPopup.nix" { };
  translate = x.customPkgs "qute/translate.nix" { };
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
    ",p" = "spawn --userscript qute-keepass -p ${x.pass}";
    # transPopup
    ",t" = "spawn --userscript ${translate}/exe -s en -t ru";
    ",T" = "spawn --userscript ${tranPopup}/exe --target_lang ru";
    # tabs
    ",b" = "config-cycle tabs.show always switching";
    ",s" = "config-cycle statusbar.show in-mode always";
  };
}
