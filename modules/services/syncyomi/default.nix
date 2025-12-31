{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# sync reading progress
# between tachi forks

{
  imports = [ ./module.nix ];
}
// (mkIf (config.services.suwayomi-server.enable) {
  persist.dirs = [ "/var/lib/syncyomi" ];

  services.syncyomi = {
    enable = true;
    openFirewall = true;

    port = 4568;
    config.host = "0.0.0.0";
    # INFO:
    # 0.0.0.0 for wan share
  }
  // genAttrs [
    "user"
    "group"
  ] (n: system.userName);
})
