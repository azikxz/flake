{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: terminal client for reddit

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.tuir ];

  hm.xdg.configFile = {
    "tuir/tuir.cfg".text = lib.generators.toINI { } {
      tuir = {
        flash = "False";
        clipboard_cmd = "wl-copy";
      };
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      tuir = prev.tuir.overrideAttrs (old: {
        version = "1.32.0";

        src = final.fetchFromGitLab {
          owner = "Chocimier";
          repo = "tuir";
          rev = "v${version}";
          hash = "sha256-lUK6gXwvVjiYrJXMSFlzp07Yt+nSkU933J4vBJWOLlg=";
        };
      });
    })
  ];
}
