{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# download pictures from web

mkIf (mac "pcRyazenka") {
  hmPackages = [ pkgs.rbw-fzf ];

  hm.programs.rbw = {
    enable = true;

    settings = {
      "email" = "xfalwa@gmail.com";
      "base_url" = "https://vault.vaultwarden.net";
      "lock_timeout" = 60 * 30;
      "sync_interval" = 4;
      "pinentry" = pkgs.pinentry-gnome3;
    };
  };
}
