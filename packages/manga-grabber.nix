{
  pkgs,
  lib,
}:

pkgs.buildGoModule rec {
  pname = "readmanga-grabber";
  version = "hotfix";

  src = pkgs.fetchFromGitHub {
    owner = "lirix360";
    repo = "ReadmangaGrabber";
    rev = version;
    hash = "sha256-J2kyHIx8wXkRdZEXsv87MJ+uMqOTqIHQX/PBGMP+n1A=";
  };

  vendorHash = "sha256-x7qwo7MwAAHYfpTOzP518rsE1PF506N1p35rBgsegBI=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Downloader for ru manga sources";
    homepage = "https://github.com/lirix360/ReadmangaGrabber";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "ReadmangaGrabber";
  };
}
