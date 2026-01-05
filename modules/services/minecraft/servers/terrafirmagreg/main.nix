{
  pkgs,
  lib,
  ...
}:

let
  modpack = pkgs.terrafirmagreg;
in

{
  enable = true;
  autoStart = false;
  # cause it is my personal pc, not server

  managementSystem = {
    tmux.enable = false;
    systemd-socket.enable = true;
  };

  package = pkgs.forgeServer;
  # i cant do it better, lolz

  jvmOpts = lib.concatStringsSep " " [
    "-Xmx6024M"
    "-Xms1024M"
  ];

  serverProperties = {
    # https://minecraft.wiki/w/Formatting_codes?section=8#Use_in_server.properties_and_pack.mcmeta
    # there is guide for colorize and styling servername
    motd = "§d§o[ TerraFirmaGreg Modern ]";

    view-distance = 14;
    max-players = 8;

    enable-rcon = true;
    "rcon.password" = "@MCRCON_PASS@";

    online-mode = false;
    # true to license minecraft only
    # i will use 'Alternative Authentication'
    # for ely.by support couse - why not?

    server-port = 25502;
    # i use keendns to open server in worldwideweb
    # https://minecraft.ebola.netcraze.pro
    # in server list paste it like (without https://)
    # minecraft.ebola.netcraze.pro
  };

  operators = {
    # for get uuid
    # https://minecraft.wiki/UUID#Player_UUID
    _azikx = {
      uuid = "e6074fe1-b0d5-4394-a860-c84987c52d9a";
      level = 0;
    };
  };

  symlinks = lib.genAttrs [
    "mods"
    "server-icon.png"
  ] (n: "${modpack}/${n}");

  files = lib.genAttrs [
    "config"
    "defaultconfigs"
    "kubejs"
    "tacz"
  ] (n: "${modpack}/${n}");
}
