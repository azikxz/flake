{
  pkgs,
  lib,
}:

{
  src,

  subDir ? ".",
  extraFiles ? [ ],
}:

pkgs.runCommand
  (lib.concatStringsSep "-" [
    src.name
    src.rev
  ])
  { }
  ''
    mkdir -p $out
    cp ${
      lib.concatStringsSep " " (
        map (file: "${src}/${subDir}/${file}") (
          [
            "manifest.json"
            "theme.css"
          ]
          ++ extraFiles
        )
      )
    } $out/
  ''
