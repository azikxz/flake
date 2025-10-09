{ pkgs, lib }:

lib.extendMkDerivation {
  constructDrv = pkgs.buildNpmPackage;

  extendDrvArgs =
    final:
    {
      dist ? "dist",
      ...
    }:
    {
      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp ${dist}/manifest.json ${dist}/main.js $out/
        [ -f ${dist}/styles.css ] && cp ${dist}/styles.css $out/

        runHook postInstall
      '';
    };
}
