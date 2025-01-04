{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.zapret;
in
{
  options = {
    module.services.zapret = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services = {
      zapret = True // {
        params = [
          "--dpi-desync=syndata,fake,split2"
          "--dpi-desync-fooling=md5sig"
          "--dpi-desync-repeats=6"
        ];
        httpMode = "full";
        udpSupport = true;
        udpPorts = [ "50000:50099" ];
        whitelist = [
          "googlevideo.com"
          "youtubei.googleapis.com"
          "ytimg.com"
          "yt3.ggpht.com"
          "yt4.ggpht.com"
          "youtube.com"
          "youtubeembeddedplayer.googleapis.com"
          "ytimg.l.google.com"
          "jnn-pa.googleapis.com"
          "youtube-nocookie.com"
          "youtube-ui.l.google.com"
          "yt-video-upload.l.google.com"
          "wide-youtube.l.google.com"
          "gstatic.com"
          "discord.gg"
          "discord.media"
          "discordapp.com"
          "discordapp.net"
          "dl.discordapp.net"
          "discordapp.io"
          "discord.com"
          "discordcdn.com"
          "discord.dev"
          "discord.new"
          "discord.gift"
          "dis.gd"
          "discordstatus.com"
          "animego.org"
          "animego.pro"
          "jut.su"
        ];
      };
      dnscrypt-proxy2 = {
        enable = true;
        settings = {
          server_names = [
            "cloudflare"
            "scaleway-fr"
            "google"
            "yandex"
          ];
          listen_addresses = [
            "127.0.0.1:53"
            "[::1]:53"
          ];
        };
      };
    };
  };
}
