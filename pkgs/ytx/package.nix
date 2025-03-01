{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "yt-x";
  version = "git";
  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    install -Dm755 ${
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Benexl/yt-x/refs/heads/master/yt-x";
        sha256 = "sha256-LLs6dTmQ5+hUcxlN/PtkJjoCu3UEesOB9KuEBifObso=";
        executable = true;
      }
    } -t $out/bin
    wrapProgram $out/bin/yt-x \
      --prefix PATH : ${
        lib.makeBinPath (
          with pkgs;
          [
            yt-dlp
            jq
            fzf
            mpv
            ffmpeg
            gum
          ]
        )
      }
  '';
}
