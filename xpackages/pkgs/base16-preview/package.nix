{ pkgs }:

pkgs.writeScriptBin "base16-preview" (
  builtins.readFile (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/xmozoid/base16/refs/heads/master/tools/base16-preview/base16-preview.py";
      sha256 = "sha256-NQdCm73E7BS6EXrygIS6TmjwkVIwZwIyBaHuvo6p8B0=";
    }
  )
)
