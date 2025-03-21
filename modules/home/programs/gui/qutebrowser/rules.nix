{
  config,
  ...
}:

{
  module.programs.gui.qutebrowser = {
    quickmarks = {
      # localhost
      keenWeb = "192.168.1.1";
      qBittorrent = "localhost:8080";
      flood = "localhost:8085";
      transmission = "localhost:9091";
      torrserver = "localhost:8090";
      syncthing = "localhost:8384";
      # nix
      nixpkgs = "search.nixos.org/packages?channel=unstable";
      homemanager = "home-manager-options.extranix.com/?query=&release=master";
      hydra = "hydra.nixos.org";
      prTracker = "nixpk.gs/pr-tracker.html";
      cachix = "app.cachix.org/cache/xache";
      noogle = "noogle.dev";
      # git
      ultima = "git.sr.ht/~neverness/ultima";
      # social
      youtube = "youtube.com";
      redlib = "l.opnxng.com";
      twitch = "twitch.tv";
      gmail = "mail.google.com";
      protonMail = "mail.proton.me";
      mastodonMl = "mastodon.ml";
      vk = "vk.com";
      # anime etc
      animeGo = "animego.club/index";
      mangaLib = "mangalib.me";
      urusai = "urusai.social";
      # torrents
      rutracker = "rutracker.org";
      # games
      modrinth = "modrinth.com";
      mineWiki = "ru.minecraft.wiki";
      broTorrent = "brotorrent.net";
      freeTP = "freetp.org";
      # study
      profteh = "profteh.com/study";
      chatGpt = "chatgpt.com";
      gemini = "gemini.google.com";
    };
    whitelist."whitelist" = {
      includes = [
        # localhost
        "qute://start/*"
        "http://localhost:*/*"
        "http://192.168.1.1/*"
        "http://localhost:8080/*"
        "http://localhost:8090/*"
        "http://localhost:8384/*"
        # sites
        "https://priv.au/*"
        "https://rutracker.org/*"
        "*://*.youtube.com/*"
        "https://www.youtube.com/*"
        "https://*.google.com/*"
        "https://mail.google.com/*"
        "https://vk.mail.ru/*"
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
            body {  background-color:  ${base00};
                    font-family:      "${font.monospace.name}" !important; }
            input { color:             ${base05};
                    background-color:  ${base01};
                    border-radius:     8px !important;
                    font-family:      "${font.monospace.name}" !important; }
            .bookmarks { display:    none;   }
            .header    { margin-top: 220px;  }
            .logo      { visibility: hidden; }
          '';
      };
    };
  };
}
