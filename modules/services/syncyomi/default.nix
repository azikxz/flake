{
  lib,
  ...
}:

with lib;
# INFO:
# server for manga/manhwa reading
# with builtin webui

{
  imports = [ ./module.nix ];
}
// (mkIf false {
  persist.dirs = [ "/var/lib/syncyomi" ];

  services.syncyomi = {
    enable = true;
    openFirewall = true;

    config.host = "0.0.0.0";
  }
  // genAttrs [ "user" "group" ] (n: system.userName);
})
