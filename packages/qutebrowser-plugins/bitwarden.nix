{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python3Packages;
in
with pyPkgs;

# needs bw
# but i dont use it
#
# garbage

buildPythonApplication {
  pname = "qute-bitwarden";
  version = "git";

  src = ./script.py;

  dontUnpack = true;

  propagatedBuildInputs = [ pkgs.python3 ];

  dependencies = [
    pkgs.python3Packages.pyperclip
    pkgs.python3Packages.tldextract
    pkgs.keyutils
    pkgs.rofi
    (buildPythonApplication {
      pname = "keyctl";
      version = "0.5";
      pyproject = true;

      src = pkgs.fetchPypi {
        pname = "keyctl";
        version = "0.5";
        hash = "sha256-Ht1uG1sXmC28QBY4M9uNZJgAaqndYMhHpmmmkNji7q8=";
      };

      build-system = with pyPkgs; [
        setuptools
        hatchling
        poetry-core
      ];
      dependencies = [
        pkgs.keyutils
        prompt-toolkit
      ];
    })
  ];

  format = "other";

  installPhase = ''
    install -Dm755 $src $out/bin/qute-bitwarden
  '';

  meta = {
    description = "Fill logins via bitwarden";
    homepage = "https://github.com/qutebrowser/qutebrowser/blob/main/misc/userscripts/qute-bitwarden";
    license = lib.licenses.gpl3;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikxz ];
    mainProgram = "qute-bitwarden";
  };
}
