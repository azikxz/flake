{
  config,
  ...
}:
{
  module.programs.gui.qutebrowser = {
    quickmarks = {
      # localhost
      torrserver = "localhost:8090";
      syncthing = "localhost:8384";
      # nix
      nixpkgs = "search.nixos.org/packages?channel=unstable";
      home-manager = "home-manager-options.extranix.com/?query=&release=master";
      # git
      ultima = "git.sr.ht/~neverness/ultima";
      # social
      youtube = "youtube.com";
      redlib = "l.opnxng.com";
      twitch = "twitch.tv";
      protonMail = "mail.proton.me";
      mastodonMl = "mastodon.ml";
      vk = "vk.com";
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
        # localhost
        "http://localhost:8090/*"
        "http://localhost:8384/*"
        # sites
        "https://rutracker.org/*"
        "*://*.youtube.com/*"
        "https://www.youtube.com/*"
        "https://*.google.com/*"
        "https://mail.proton.me/*"
        "https://account.proton.me/*"
        "https://*.proton.me/*"
        "https://www.reddit.com/*"
        "https://mastodon.ml/*"
        "https://github.com/*"
        "https://archlinux.org/*"
        "https://*.extranix.com/*"
        "https://home-manager-options.extranix.com/*"
        "https://git.sr.ht/*"
        "https://*.sr.ht/*"
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
        includes = [ "qute://start/" ];
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
