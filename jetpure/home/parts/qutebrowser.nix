{ config, ... }:
{
  module.programs.gui.qutebrowser = {
    quickmarks = {
      # localhost
      torrserver = "localhost:8090";
      syncthing = "localhost:8384";
      # nix
      nixpkgs = "search.nixos.org/packages?channel=unstable";
      home-manager = "home-manager-options.extranix.com/?query=&release=master";
      # social
      youtube = "youtube.com";
      redlib = "l.opnxng.com";
      twitch = "twitch.tv";
      protonMail = "mail.proton.me";
      mastodonMl = "mastodon.ml";
      # anime etc
      animeGo = "animego.me";
      mangaLib = "mangalib.me";
      urusai = "urusai.social";
      # torrents
      rutracker = "rutracker.org";
      # games
      modrinth = "modrinth.com";
      mineWiki = "ru.minecraft.wiki";
      broTorrent = "brotorrent.net";
      freeTP = "freetp.org";
    };
    whitelist."whitelist" = {
      includes = [
        "*://*.youtube.com/*"
        "https://www.youtube.com/*"
        "https://*.google.com/*"
        "https://mail.proton.me/*"
        "https://www.reddit.com/*"
        "https://mastodon.ml/*"
        "https://github.com/*"
        "https://archlinux.org/*"
        "https://*.extranix.com/*"
        "https://home-manager-options.extranix.com/*"
      ];
      text = # js
        ''
          const meta = document.createElement('meta');
          meta.name = "color-scheme";
          meta.content = "dark light";
          document.head.appendChild(meta);
        '';
    };
    userstyle = {
      "start" = {
        includes = [
          "qute://start/"
          "qute://start"
          "qute://start/*"
        ];
        text =
          let
            font = config.stylix.fonts;
          in
          with config.lib.stylix.colors.withHashtag;
          # css
          ''
            body {
              background-color: #101010;
              font-family: "${font.monospace.name}" !important;
            }
            input {
              background-color: ${base01};
              border-radius: 8px !important;
              font-family: "${font.monospace.name}" !important;
            }
            .bookmarks { display: none; }
            .header { margin-top: 220px; }
            .logo { visibility: hidden; }
          '';
      };
    };
  };
}
