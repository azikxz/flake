{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.virt.podman;
in
{
  options = {
    module.virt.podman = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ podman-compose ];
    virtualisation = {
      spiceUSBRedirection = on;
      podman = on // {
        dockerSocket = on;
        dockerCompat = true;
        autoPrune.enable = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
    };
  };
}
