{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.services.minecraft-servers;

  dir = "/var/lib/minecraft";
in
# INFO:
# your absolute awesome minecraft server
# in some lines of code
# with auto generator servers

mkIf false {
  persist.dirs = [ dir ];

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

  packages = with pkgs; [
    packwiz
    mcrcon
  ];

  # i made two secrets couse owners diffirent
  hm.home.sessionVariables = {
    MCRCON_PASS = "$(cat ${config.sopsnix."services/minecraft-main"})";
  };

  services.minecraft-servers = {
    enable = true;
    openFirewall = true;

    eula = true;
    dataDir = dir;
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
              inputs
              pkgs
              lib
              ;
          };

      in
      mapAttrs (name: _: loadServer name) (
        filterAttrs (_: v: v == "directory") (builtins.readDir serverDirs)
      );
    # auto generator server
    # .
    #  servers
    # ├  modded
    # │ ├──  jvmOpts.nix
    # │ ├──  main.nix
    # │ └──  mods.nix
    # └  vanilla
    #   ├──  jvmOpts.nix
    #   ├──  main.nix
    #   └──  mods.nix
    #  default.nix
  };
}
