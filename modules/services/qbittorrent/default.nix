{
  lib,
  ...
}:

with lib;

{
  imports = [ ./module.nix ];
}
// (mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.dirs = [ "/var/lib/qBittorrent" ];

  services.qbittorrent = {
    enable = true;

    torrentingPort = 6881;
  };
})
