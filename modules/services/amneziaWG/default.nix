{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

# INFO: generate warp configs here
# https://generator-warp.vercel.app

# INFO: create ./connection.conf and fill it
#
# git add --intent-to-add ./*.conf
# git update-index --skip-worktree --assume-unchanged ./*.conf
#
# rebuild

mkIf (mac "pcRyazenka") {
  environment = {
    etc = (
      listToAttrs (
        map (
          file:
          let
            name = baseNameOf file;
          in
          {
            name = "amnezia/amneziawg/${name}";
            value.source = ./${name};
          }
        ) (filter (f: match ".*\\.conf$" f != null) (attrNames (builtins.readDir ./.)))
      )
    ) # awg-quick up ${name}
    ;

    systemPackages = with pkgs; [
      amneziawg-tools
      amneziawg-go
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
}
