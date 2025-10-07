{ pkgs, lib }:

let
  src = pkgs.fetchFromGitHub {
    owner = "kepano";
    repo = "obsidian-minimal";
    rev = "8.0.1";
    sha256 = "sha256-9FHkJ47R+cy2Pq62OuUUZQLSxd929xUIsQcpFGb4rso=";
  };

  subDir = ".";
  extraFiles = [ ];
in

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
