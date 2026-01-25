{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python3Packages;
in
with pyPkgs;

buildPythonApplication {
  pname = "qute-rbw";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/axax-loll/46ae13e0ea722203a13e318c871bb349/raw/43fff9e527b044d87afccfab1529785cd39c5ca2/qute_rbw_x.py";
    sha256 = "sha256-4qTZmN8qIPlMnutobGYc56gsrTIwZpzv7Md476fv9ig=";
  };

  dontUnpack = true;

  propagatedBuildInputs = [ pkgs.python3 ];

  format = "other";

  installPhase = ''
    install -Dm755 $src $out/bin/qute-rbw
  '';

  meta = {
    description = "Fill logins via rbw from qutebrowser";
    homepage = "https://gist.github.com/azikz/46ae13e0ea722203a13e318c871bb349";
    license = lib.licenses.wtfpl;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikxz ];
    mainProgram = "qute-rbw";
  };
}
