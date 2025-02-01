{
  x,
  ...
}:
with x;
let
  us = "spawn --userscript";
  translate = x.customPkgs "qute/translate.nix" { };
in
{
  home.packages = [ translate ];
  programs.qutebrowser = on // {
    keyBindings = {
      normal = {
        # move tabs
        "<Alt-j>" = "tab-move +";
        "<Alt-k>" = "tab-move -";
        # mpv
        ";h" = "open qute://start/";
        # mpv
        ";m" = "spawn mpv {url}";
        ";M" = "hint links spawn mpv {hint-url}";
        # keepassxc
        ";p" = "${us} qute-keepass -p ${x.pass}";
        # translate
        ";t" = "${us} ${translate}/translate -s en -t ru";
        ";T" = "hint links userscript ${translate}/translate";
        # tabs
        ";b" = "config-cycle tabs.show always switching";
        ";s" = "config-cycle statusbar.show in-mode always";
      };
      caret = {
        # translate
        "t" = "${us} ${translate}/translate --text -s en -t ru";
      };
    };
  };
}
