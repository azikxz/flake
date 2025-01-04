{ pkgs, x, ... }:
with x;
let
  translate =
    with pkgs;
    callPackage (
      { pkgs }:
      stdenv.mkDerivation {
        name = "qute-translate";
        src = pkgs.fetchFromGitHub {
          owner = "AckslD";
          repo = "Qute-Translate";
          rev = "cd2d201d17bb2d7490700b20d94495327af15e78";
          sha256 = "sha256-xCbeEAw8a/5/ZD9+aB1J7FxLLBlP65kslGtpYGn3efs=";
        };
        installPhase = ''
          install -Dm555 translate $out/translate
        '';
      }
    ) { };
in
{
  home.packages = [ translate ];
  programs.qutebrowser = True // {
    keyBindings = {
      normal = {
        # j/k
        "e" = "cmd-run-with-count 10 scroll down";
        "E" = "cmd-run-with-count 10 scroll up";
        # mpv
        ",m" = "spawn mpv {url}";
        ",M" = "hint links spawn mpv {hint-url}";
        # qute pass
        # zz = "${us} qute-pass";
        # zu = "${us} qute-pass --username-only";
        # zp = "${us} qute-pass --password-only";
        # translate
        ",t" = "spawn --userscript ${translate}/translate -s en -t ru";
        ",T" = "hint links userscript ${translate}/translate";
      };
      caret = {
        "t" = "spawn --userscript ${translate}/translate --text -s en -t ru";
      };
    };
  };
}
