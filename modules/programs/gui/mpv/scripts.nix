{
  pkgs,
  ...
}:

with pkgs.mpvScripts;
let
  inherit (pkgs)
    fetchFromGitHub
    ;

  mk =
    pname: attrs:
    buildLua {
      inherit pname;
      version = "unstable";
      src = fetchFromGitHub attrs;
    };
in

[
  (quality-menu.override { oscSupport = true; })
  sponsorblock-minimal
  thumbnail
]
++ [
  (mk "navigator" {
    owner = "jonniek";
    repo = "mpv-filenavigator";
    rev = "51242195da9b3231ab7fde367a63dc58fb6858f3";
    hash = "sha256-JjYDBdoPcNH+SVbOIFICJSM1sH6t6IEA2yHnHMbHpV8=";
  })
]
