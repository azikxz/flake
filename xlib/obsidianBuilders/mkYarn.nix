{
  pkgs,
}:

{
  pname ? "",
  version ? "",

  src ? { },

  yarnOfflineCache ? { },
  buildInputs ? [ ],

  meta,
  ...
}:

pkgs.stdenv.mkDerivation {
  inherit
    pname
    version
    src
    yarnOfflineCache
    meta
    ;

  nativeBuildInputs =
    with pkgs;
    [
      yarnConfigHook
      yarnBuildHook
      yarnInstallHook
      nodejs
    ]
    ++ buildInputs;

  installPhase = ''
    mkdir -p $out/
    cp main.js manifest.json $out/
    cp main.css $out/styles.css
  '';
}
