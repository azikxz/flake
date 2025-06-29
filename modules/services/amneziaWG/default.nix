{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  systemd = false;

  mk = n: "sudo ${getExe' pkgs.amneziawg-amneziawg-tools "awg-quick"} ${n} config";
in

{
  environment = {
    etc = builtins.listToAttrs (
      map
        (
          file:
          let
            name = builtins.baseNameOf file;
          in
          {
            name = "amnezia/amneziawg/${name}";
            value.source = ./${name};
          }
        )
        (
          builtins.filter (f: builtins.match ".*\\.conf$" f != null) (
            builtins.attrNames (builtins.readDir ./.)
          )
        )
    ) # awg-quick up ${name}
    ;

    systemPackages = with pkgs; [
      amneziawg-tools
      amneziawg-go
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];

  systemd.services.warp = mkIf systemd {
    enable = true;

    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    path = [ pkgs.amneziawg-go ];

    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = mk "up";
      ExecStop = mk "down";
      RemainAfterExit = "yes";
    };
  };
}
