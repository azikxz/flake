{
  x,
  pkgs,
  ...
}:
with x;
let
  inherit (pkgs) callPackage;
  us = "spawn --userscript";
  translate =
    with pkgs;
    callPackage (
      { pkgs }:
      stdenv.mkDerivation rec {
        name = "translate";
        installPhase = ''install -Dm555 ${name} $out/${name}'';
        src = pkgs.fetchFromGitHub {
          owner = "AckslD";
          repo = "Qute-Translate";
          rev = "cd2d201d17bb2d7490700b20d94495327af15e78";
          sha256 = "sha256-xCbeEAw8a/5/ZD9+aB1J7FxLLBlP65kslGtpYGn3efs=";
        };
      }
    ) { };
in
{
  home.packages = with pkgs.python312Packages; [
    translate
    pynacl
  ];
  programs.qutebrowser = True // {
    keyBindings = {
      normal = {
        # mpv
        "gh" = "open qute://start/";
        # mpv
        ",m" = "spawn mpv {url}";
        ",M" = "hint links spawn mpv {hint-url}";
        # keepassxc
        pw = "${us} qute-keepass -p ${x.pass}";
        # translate
        ",t" = "${us} ${translate}/translate -s en -t ru";
        ",T" = "hint links userscript ${translate}/translate";
      };
      caret = {
        # translate
        "t" = "${us} ${translate}/translate --text -s en -t ru";
      };
    };
  };
}
