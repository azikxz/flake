{ pkgs }:

pkgs.fishPlugins.buildFishPlugin {
  pname = "fish-helix";
  version = "0.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "llakala";
    repo = "fish-helix";
    rev = "e18079be94f587763c9758ccdabdfdb743a136aa";
    hash = "sha256-nN86dEIA+mi+yWwOJHCVprT2KZmDanUWfxsZsN4p9s4=";
  };
}
