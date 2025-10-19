{
  pkgs,
  obsidian,
}:

obsidian.mkTheme {
  src = pkgs.fetchFromGitHub {
    owner = "kepano";
    repo = "obsidian-minimal";
    rev = "8.0.1";
    sha256 = "sha256-9FHkJ47R+cy2Pq62OuUUZQLSxd929xUIsQcpFGb4rso=";
  };
}
