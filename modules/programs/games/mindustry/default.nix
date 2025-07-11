{
  pkgs,
  lib,
  ...
}:

with lib;
let
  server = false;
in

(mkIf (mac "thinkpadT14") {
  persist.user.dirs = [ ".srb2" ];

  environment.systemPackages = with pkgs; [ mindustry-wayland ];
})
// (optionalAttrs server {
  environment.systemPackages = with pkgs; [ mindustry-server ];

  networking.firewall =
    pipe
      [
        "TCP"
        "UDP"
      ]
      [
        (builtins.map (
          protocol:
          nameValuePair "allowed${protocol}Ports" [
            cfg.port
          ]
        ))
        builtins.listToAttrs
      ];
})
