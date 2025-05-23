{
  pkgs,
  ...
}:

with pkgs.mpvScripts;
let
  inherit (pkgs) fetchFromGitHub;
in

[
  sponsorblock-minimal
  thumbnail
]
++ [
  (buildLua {
    pname = "navigator";
    version = "unstable";

    src = fetchFromGitHub {
      owner = "jonniek";
      repo = "mpv-filenavigator";
      rev = "51242195da9b3231ab7fde367a63dc58fb6858f3";
      hash = "sha256-JjYDBdoPcNH+SVbOIFICJSM1sH6t6IEA2yHnHMbHpV8=";
    };
  })
]
