{ pkgs }:

(pkgs.callPackage ../template/npm.nix { }) (final: {
  pname = "advanced-tables-obsidian";
  version = "0.22.1";

  src = pkgs.fetchFromGitHub {
    owner = "tgrosinger";
    repo = "advanced-tables-obsidian";
    rev = final.version;
    sha256 = "sha256-eWKn3qEYsVfOsO3LL0mj4HHOuoLvag4mcWXXDMfH2GM=";
  };

  postPatch = ''
    cp ${./package.json} package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-6gL5uYhCfyYZOvc3ymACOpEFQQzTZIQnFMTWnr6xkVU=";

  dist = ".";
})
