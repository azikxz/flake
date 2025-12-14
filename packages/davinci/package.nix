{
  pkgs,
  lib,
}:

# INFO:
# all patches taken from this
# https://rutracker.org/forum/viewtopic.php?t=6088055

let
  pkg = pkgs.davinci-resolve-studio;

  # only for 25.11 | 25.05 | 24.11
  patches = (import ./patches.nix).${pkg.version};

  drv = pkg.override (prev: {
    buildFHSEnv =
      old:
      (prev.buildFHSEnv (
        old
        // {
          extraBwrapArgs = lib.filter (n: !(lib.strings.hasInfix "license" n)) old.extraBwrapArgs;
        }
      ));
  });

  replacements = [
    rec {
      oldDependency = drv.passthru.davinci;
      newDependency = oldDependency.overrideAttrs (
        final: prev: {
          postFixup = ''
            ${prev.postFixup}
            ${
              (
                patches:
                lib.concatStringsSep "\n" (
                  map (p: ''
                    ${lib.getExe pkgs.perl} -pi -e ${lib.escapeShellArg p} $out/bin/resolve
                  '') patches
                )
              )
              patches.list
            }
          ''
          + patches.lines;
        }
      );
    }
  ];
in

pkgs.replaceDependencies {
  inherit
    drv
    replacements
    ;
}
