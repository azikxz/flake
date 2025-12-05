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
    sha256 = "sha256-TGToK2k9zpd5LappqlkGgxJliXqE4HzsBq07c4IN+T4=";
  };

  meta = {
    description = "A distraction-free and highly customizable theme for Obsidian.";
    homepage = "https://github.com/kepano/obsidian-minimal";
    license = lib.licenses.mit;
  };
}
