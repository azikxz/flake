{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

# INFO:
# generate warp configs here
# https://generator-warp.vercel.app

# INFO:
# create ./connection.conf and fill it
#
# > git add --intent-to-add ./*.conf
# > git update-index --skip-worktree --assume-unchanged ./*.conf
#
# or via sopsnix/agenix
#
# rebuild

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment = {
    etc =
      let
        genSops = mapAttrs' (
          sopsPath: source:
          let
            name = last (splitString "/" sopsPath);
            etcPath = "amneziawg/${name}.conf";
          in
          nameValuePair etcPath {
            inherit
              source
              ;
          }
        ) (filterAttrs (path: _: hasPrefix "vpn/amneziawg/" path) (config.sopsnix or { }));
      in
      genSops
      // (listToAttrs (
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
      )) # awg-quick up ${name}
    ;

    systemPackages = with pkgs; [
      amneziawg-tools
      amneziawg-go
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
}
