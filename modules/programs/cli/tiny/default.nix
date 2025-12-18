{
  lib,
  ...
}:

with lib;
# INFO:
# tui irc client

mkIf false {
  hm.programs.tiny = {
    enable = true;

    settings = {
      servers = [
        {
          realname = "azikx";
          nicks = [
            "nixzoid"
            "hackerx"
          ];
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
        }
      ];
    };
  };
}
