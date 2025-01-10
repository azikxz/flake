{ pkgs, ... }:
with pkgs;
{
  config = (
    let
      qute-translate = callPackage (
        { pkgs }:
        stdenv.mkDerivation {
          name = "qute-translate";
          src = pkgs.fetchFromGitHub {
            owner = "AckslD";
            repo = "Qute-Translate";
            rev = "cd2d201d17bb2d7490700b20d94495327af15e78";
            sha256 = "sha256-xCbeEAw8a/5/ZD9+aB1J7FxLLBlP65kslGtpYGn3efs=";
          };
          installPhase = "install -Dm555 translate $out/translate";
        }
      ) { };
      qute-keepassxc = callPackage (
        { pkgs }:
        stdenv.mkDerivation {
          name = "qute-keepassxc";
          src = pkgs.fetchFromGitHub {
            owner = "ususdei";
            repo = "qute-keepassxc";
            rev = "b2338f206b47d74904d85d92a856917c32a9d5eb";
            hash = "sha256-cuTcwekXALoz/dWn6SVszrcFQSN0/y+8iWecnW/6fNU=";
          };
          installPhase = "install -Dm555 qute-keepassxc $out/qute-keepassxc";
        }
      ) { };
    in
    {
      home.packages = [
        qute-translate
        qute-keepassxc
      ];
      programs.qutebrowser.keyBindings.normal = {
        ",t" = "spawn --userscript ${qute-translate}/translate";
        ",x" = "spawn --userscript ${qute-keepassxc}/qute-keepassxc --key ABC1234";
      };
    }
  );
}
