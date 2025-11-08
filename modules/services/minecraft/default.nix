{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.services.minecraft-servers;
in
# INFO:
# your absolute awesome minecraft server
# in some lines of code
# with auto generator servers

mkIf (mac "pcRyazenka") {
  sops.secrets = {
    "services/minecraft" = {
      owner = mkForce cfg.user;

      reloadUnits = concatMap (name: [
        "${"minecraft-server-${name}.socket"}"
        "${"minecraft-server-${name}.service"}"
      ]) (attrNames cfg.servers);
      # when u change password
      # servers will be restarted
    };
  };

  services.minecraft-servers = {
    enable = true;

    eula = true;
    openFirewall = true;

    dataDir = "/var/lib/minecraft";
    environmentFile = config.sopsnix."services/minecraft";
    # just a plain file
    #
    # password=yourawesomepass

    servers =
      let
        serverDirs = ./servers;

        loadServer =
          name:
          import (serverDirs + "/${name}/main.nix") {
            inherit
              pkgs
              lib
              ;
          };

      in
      mapAttrs (name: _: loadServer name) (
        filterAttrs (_: v: v == "directory") (builtins.readDir serverDirs)
      );
    # auto generator server
    #  .
    # ├  servers
    # │ ├  modded
    # │ │ ├──  jvmOpts.nix
    # │ │ ├──  main.nix
    # │ │ └──  mods.nix
    # │ └  vanilla
    # │   ├──  jvmOpts.nix
    # │   ├──  main.nix
    # │   └──  mods.nix
    # └  default.nix
  };
}
