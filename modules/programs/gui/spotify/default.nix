{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: idk how to login, i am via dns.malw.link
# okay... sometimes via vpn lol

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [
    ".config/spotify"
    ".cache/spotify"
  ];

  environment.systemPackages = [ pkgs.spotdl ];

  hm.programs.spicetify = {
    enable = true;

    inherit
      (import ./addons.nix {
        inherit
          pkgs
          config
          ;
      })
      theme
      enabledExtensions
      enabledSnippets
      ;

    wayland = true;
    windowManagerPatch = true;

    colorScheme = "custom";
    customColorScheme = import ./theme.nix {
      inherit
        config
        ;
    };
  };
}
