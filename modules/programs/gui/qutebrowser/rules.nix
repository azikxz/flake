{
  config,
  ...
}:

{
  quickmarks = {
    # search
    _4get = "4get.nadeko.net";
    # localhost
    keenWeb = "192.168.1.1";
    flood = "localhost:8085";
    transmission = "localhost:9091";
    torrserver = "localhost:8090";
    syncthing = "localhost:8384";

    # nix
    nixpkgs = "search.nixos.org/packages?channel=unstable";
    homemanager = "home-manager-options.extranix.com/?query=&release=master";
    searchix = "searchix.ovh";
    myNixOS = "mynixos.com";
    nixosWiki = "wiki.nixos.org";
    hydra = "hydra.nixos.org";
    prTracker = "nixpk.gs/pr-tracker.html";
    cachix = "app.cachix.org/cache/xache";
    noogle = "noogle.dev";

    # git
    ultima = "git.sr.ht/~neverness/ultima";
    pubSolar = "git.pub.solar/xmozoid/ultima";
    github = "github.com";

    # social
    youtube = "https://www.youtube.com";
    invidious = "inv.nadeko.net";
    redlib = "redlib.nadeko.net";
    nitter = "nitter.kareem.one";
    twitch = "twitch.tv";
    gmail = "mail.google.com";
    protonMail = "mail.proton.me";
    mastodonMl = "mastodon.ml";
    vk = "vk.com";
    dvach = "2ch.su"; # zlob >:(

    # anime etc
    animeGo = "animego.club/index";
    anilibMe = "anilib.me/ru";
    yummyAnime = "yummy-anime.org";
    dreamCast = "dreamerscast.com";
    mangaLib = "mangalib.me/ru";
    urusai = "urusai.social";

    # torrents
    rutracker = "rutracker.org";
    pirateBay = "thepiratebay.org";
    pirateBayProxy = "piratebayproxy.net";

    # games
    modrinth = "modrinth.com";
    mineWiki = "ru.minecraft.wiki";
    broTorrent = "brotorrent.net";
    freeTP = "freetp.org";
    steamDB = "steamdb.info";
    protonDB = "protondb.com";

    # study
    profteh = "profteh.com/study";
    chatGpt = "chatgpt.com";
    deekpeek = "chat.deepseek.com";
    gemini = "gemini.google.com";
    frok = "grok.com"; # hitler???

    # wallpapers
    wallHaven = "wallhaven.cc"; # nazi????
    wallpapers = "wallpapers.com";
    wallReddit = "l.opnxng.com/r/wallpaper";

    # misc
    base16Preview = "sesh.github.io/base16-viewer";
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
          (mk "nadeko.net")
          (mk "*.nadeko.net")
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

  userstyle = with config.lib.stylix.colors.withHashtag; {
    "start" = {
      includes = [
        "qute://start/"
        "qute://bookmarks/"
      ];

      text =
        # css
        ''
          body {
                  background-color:  ${base00};
                  font-family:      "${config.stylix.fonts.monospace.name}" !important;
                }  
          h1 {
                  color: ${base05};
                  font-weight: normal;
                }
          a {
                  text-decoration: none;
                  color: ${base0B};
                }  
          input {
                  color:             ${base05};
                  background-color:  ${base01};
                  border-radius:     8px !important;
                  font-family:      "${config.stylix.fonts.monospace.name}" !important;
                }
          .bookmarks { display:    none;   }
          .header    { margin-top: 220px;  }
          .logo      { visibility: hidden; }
        '';
    };

    "youtube" = {
      includes = [
        "*://*.youtube.com/*"
        "*://music.youtube.com/*"
      ];

      text =
        # css
        ''
          #country-code.ytd-topbar-logo-renderer { display: none; }

          yt-button-shape                        { display: none; }

          yt-button-renderer,
          ytd-button-renderer,
          ytd-toggle-button-renderer { display: none; }
        '';
    };
  };
}
