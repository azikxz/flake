{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# module for emailing

mkIf (mac "pcRyazenka") {
  hm = {
    accounts.email = {
      maildirBasePath = "${config.hm.home.homeDirectory}/.mail";

      accounts = {
        homeMail = {
          primary = true;
          flavor = "gmail.com";
          # it makes auto set imap/smtp

          realName = "Aziz Kurbonov";
          address = "xfalwa@gmail.com";
          passwordCommand = "cat ${config.sopsnix."accounts/gmailPassword"}";
          # if u dont use 2fa  write default password
          # if u use 2fa open this page and generate key
          # https://myaccount.google.com/apppasswords
          # write as 16 digit word without spaces

          folders = {
            sent = " sent";
            inbox = " inbox";
            trash = " trash";
            drafts = " drafts";
          };

          mbsync = {
            enable = true;
            patterns = [ "*" ];

            extraConfig = {
              channel = {
                CopyArrivalDate = "yes";
              };
            };

            groups =
              let
                mkAll =
                  list:
                  mapAttrs (
                    n: ch:
                    {
                      extraConfig = {
                        Create = "Both";
                        Expunge = "Both";
                      };
                    }
                    // ch
                  ) list;
              in
              {
                core.channels = mkAll {
                  inbox = {
                    farPattern = "INBOX";
                    nearPattern = " inbox";
                  };

                  archive = {
                    farPattern = "[Gmail]/All Mail";
                    nearPattern = " archive";
                  };

                  sent = {
                    farPattern = "[Gmail]/Sent Mail";
                    nearPattern = " sent";
                  };

                  trash = {
                    farPattern = "[Gmail]/Trash";
                    nearPattern = " trash";
                  };
                };

                extra.channels = mkAll {
                  drafts = {
                    farPattern = "[Gmail]/Drafts";
                    nearPattern = " drafts";
                  };

                  starred = {
                    farPattern = "[Gmail]/Starred";
                    nearPattern = " starred";
                  };

                  important = {
                    farPattern = "[Gmail]/Important";
                    nearPattern = "󰯨 important";
                  };

                  spam = {
                    farPattern = "[Gmail]/Spam";
                    nearPattern = " spam";
                  };
                };
              };
          }
          // genAttrs [
            "create"
            "expunge"
            "remove"
          ] (n: "both"); # lazy...

          # frontends
          aerc = {
            inherit (config.hm.programs.aerc)
              enable
              ;

            extraAccounts = {
              folders-sort = [
                " inbox"
                " sent"
                " drafts"
                " starred"
                "󰯨 important"
                " archive"
                " spam"
                " trash"
              ];
            };
          };
        };
      };
    };

    # idk why to separate it to modules???
    programs.mbsync.enable = true;
    services.mbsync = {
      enable = true;

      frequency = "*:0/5"; # in minutes
      # sync will be in every 5 minutes

      verbose = true;
    };
  };
}
