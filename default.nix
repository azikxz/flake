{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "spotify-to-ytmusic";
  version = "0.7.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sigma67";
    repo = "spotify_to_ytmusic";
    rev = version;
    hash = "sha256-LGvdh1ifd9/9M79Eakr/GRGs9devFDh1mEjpwoXt+EY=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.setuptools-scm
  ];

  dependencies = with python3.pkgs; [
    platformdirs
    spotipy
    ytmusicapi
  ];

  pythonImportsCheck = [
    "spotify_to_ytmusic"
  ];

  meta = {
    description = "Clone a Spotify playlist to YouTube Music";
    homepage = "https://github.com/sigma67/spotify_to_ytmusic";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "spotify-to-ytmusic";
  };
}
