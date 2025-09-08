{
  lib,
  ...
}:

with lib;
# INFO: tui irc client

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.tiny = {
    enable = true;

    settings = {
      servers = [
        {
          realname = "azikx";
          nicks = [
            "nixzoid"
            "toneus"
          ];
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
        }
      ];
    };
  };
}
