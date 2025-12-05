{
  pkgs,
  lib,
  obsidian,
}:

obsidian.mkTheme {
  src = pkgs.fetchFromGitHub {
    owner = "kepano";
    repo = "obsidian-minimal";
    rev = "8.0.4";
    sha256 = "sha256-9FHkJ47R+cy2Pq62OuUUZQLSxd929xUIsQcpFGb4rso=";
  };

  meta = {
    description = "A distraction-free and highly customizable theme for Obsidian.";
    homepage = "https://github.com/kepano/obsidian-minimal";
    license = lib.licenses.mit;
  };
}
