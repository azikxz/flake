{
  pkgs,
  lib,
  ...
}:

{
  enable = true;
  autoStart = false;
  # cause it is my personal pc, not server

  package = pkgs.minecraftServers.vanilla-1_21_8.override {
    jre_headless = pkgs.temurin-jre-bin;
    # default oracle java is shit, temurin GOAT
  };

  # jvmOpts = "-Xmx6G -Xms2G";
  jvmOpts = lib.concatStringsSep " " (import ./jvmOpts.nix);

  serverProperties = {
    # https://minecraft.wiki/w/Formatting_codes?section=8#Use_in_server.properties_and_pack.mcmeta
    # there is guide for colorize and styling servername
    motd = "\\u00A7l\\u00A7cRegular server \\u00A7b\\u00A7o(nixed edition)";

    view-distance = 15;
    max-players = 24;

    enable-rcon = true;
    "rcon.port" = 8044;
    "rcon.password" = "@password@";

    server-port = 25565;
    # i use keendns to open server in worldwideweb
    # https://minecraft.ebola.netcraze.pro
    # in server list paste it like (without https://)
    # minecraft.ebola.netcraze.pro
  };
}
