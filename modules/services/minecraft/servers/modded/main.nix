{
  pkgs,
  lib,
  ...
}:

{
  enable = false;
  autoStart = false;

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
    "rcon.port" = 8044;
    "rcon.password" = "@password@";

    server-port = 25565;
    # maybe 65080 for keendns, idk
  };

  symlinks = {
    # soon...
    mods = import ./mods.nix {
      inherit
        pkgs
        lib
        ;
    };
  };
}
