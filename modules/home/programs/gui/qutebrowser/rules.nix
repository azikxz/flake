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
      nixosWiki = "wiki.nixos.org";
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
      includes =
        let
          pre = "*://";
          qute = "qute://";
          http = "http://";
          https = "https://";
          end = "/*";
        in
        (
          let
            mk = url: http + url + end;
            qk = url: qute + url + end;
          in
          [
            (qk "start")
            (mk "localhost:*")
            (mk "192.168.1.1")
            (mk "localhost:8080")
            (mk "localhost:8090")
            (mk "localhost:8384")
          ]
        )
        ++ (
          let
            mk = url: https + url + end;
            pk = url: pre + url + end;
          in
          [
            (mk "priv.au")
            (mk "rutracker.org")
            (pk "*.youtube.com")
            (mk "www.youtube.com")
            (mk "*.google.com")
            (mk "mail.google.com")
            (mk "vk.mail.ru")
            (mk "mail.proton.me")
            (mk "account.proton.me")
            (mk "*.proton.me")
            (mk "www.reddit.com")
            (mk "mastodon.ml")
            (mk "github.com")
            (mk "archlinux.org")
            (mk "*.extranix.com")
            (mk "home-manager-options.extranix.com")
            (mk "git.sr.ht")
            (mk "*.sr.ht")
            (mk "wiki.nixos.org")
            (mk "*.nixos.org")
          ]
        );
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
