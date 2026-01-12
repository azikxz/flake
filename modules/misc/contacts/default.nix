{
  lib,
  config,
  ...
}:

with lib;
let
  sh = cmd: [
    "sh"
    "-c"
    cmd
  ];
in
# INFO:
# module for contacting
# and supporting clients

mkIf (mac "pcRyazenka") {
  hm = {
    accounts.contact = {
      basePath = "${config.hm.home.homeDirectory}/.contacts";

      accounts = {
        homeContacts = {
          remote.type = "google_contacts";
          # nearly ill replace it

          vdirsyncer = {
            enable = true;

            # if local db have conflict
            # remote data will override local data
            conflictResolution = "remote wins";
            collections = [ "from a" ];

            # get client id/secret here
            # for google: https://console.cloud.google.com/apis
            # Enabled API & services -> enable "Google Contacts CardDAV API"
            # Credentials -> create client OAuth 2.0, copy data
            # Audience -> add your email to "Test users"
            clientIdCommand = sh "cat ${config.sopsnix."accounts/googleCardDav/id"}";
            clientSecretCommand = sh "cat ${config.sopsnix."accounts/googleCardDav/secret"}";

            tokenFile = "${config.hm.accounts.contact.basePath}/homeContacts/token";
          };

          khard = {
            inherit (config.hm.programs.khard)
              enable
              ;

            addressbooks = [ "default" ];
          };

          khal = {
            inherit (config.hm.programs.khal)
              enable
              ;

            color = config.lib.stylix.colors.withHashtag.base0B;
          };
        };
      };
    };

    programs.vdirsyncer.enable = true;
    services.vdirsyncer = {
      enable = true;

      frequency = "*:0/5"; # in minutes
      # sync will be in every 5 minutes

      verbosity = "INFO";
    };
  };
}
