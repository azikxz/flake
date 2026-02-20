{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  enable = false;
  autoStart = false;
  # cause it is my personal pc, not server

  managementSystem = {
    tmux.enable = false;
    systemd-socket.enable = true;
  };

  package = pkgs.minecraftServers.fabric-1_21_8.override {
    jre_headless = pkgs.temurin-jre-bin;
    # default oracle java is shit, temurin GOAT
  };

  jvmOpts = lib.concatStringsSep " " (import ./jvmOpts.nix);

  serverProperties = {
    # https://minecraft.wiki/w/Formatting_codes?section=8#Use_in_server.properties_and_pack.mcmeta
    # there is guide for colorize and styling servername
    motd = "\\u00A7d\\u00A7oModded adventures!!! (nixed edition)";

    view-distance = 15;
    max-players = 24;

    enable-rcon = true;
    "rcon.password" = "@MCRCON_PASS@";

    online-mode = false;
    # true to license minecraft only
    # i will use 'Alternative Authentication'
    # for ely.by support couse - why not?

    server-port = 25001;
    # i use keendns to open server in worldwideweb
    # https://minecraft.ebola.netcraze.pro
    # in server list paste it like (without https://)
    # minecraft.ebola.netcraze.pro
  };

  symlinks = {
    # "mods" = "${modpack}/mods";
  };

  files = {
    "server-icon.png" = pkgs.fetchurl {
      url = "https://github.com/unazikx/assets/blob/03d6107e20c2b117f6686bb3a3bbd6ad3909facf/minecraft/icons/vanilla.png";
      sha256 = "sha256-5YOCkJtbg8TbX2S+j5sDD7+E5h88PU0LR/yqN7nqOmU=";
    };

    # "config" = "${modpack}/config";

    "world/datapacks" = builtins.path {
      path = inputs.minecraft-assets + "/datapacks";
      name = "datapacks";
    };
  };
}
