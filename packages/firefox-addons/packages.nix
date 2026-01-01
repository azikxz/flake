{ buildFirefoxXpiAddon, lib }:
  {
    "bitwarden-password-manager" = buildFirefoxXpiAddon {
      pname = "bitwarden-password-manager";
      version = "2025.12.0";
      addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4640726/bitwarden_password_manager-2025.12.0.xpi";
      sha256 = "0256a61e84e23903fd379f5971150a8b23a53a126da62d276d57e514408839cd";
      meta = with lib;
      {
        homepage = "https://bitwarden.com";
        description = "At home, at work, or on the go, Bitwarden easily secures all your passwords, passkeys, and sensitive information.";
        license = licenses.gpl3;
        mozPermissions = [
          "<all_urls>"
          "*://*/*"
          "alarms"
          "clipboardRead"
          "clipboardWrite"
          "contextMenus"
          "idle"
          "storage"
          "tabs"
          "unlimitedStorage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "notifications"
          "file:///*"
        ];
        platforms = platforms.all;
      };
    };
    "darkreader" = buildFirefoxXpiAddon {
      pname = "darkreader";
      version = "4.9.118";
      addonId = "addon@darkreader.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4638146/darkreader-4.9.118.xpi";
      sha256 = "69d2da0e84545ee19ded9a5872f300765280cf25b2edbef7041d4d752c4c9394";
      meta = with lib;
      {
        homepage = "https://darkreader.org/";
        description = "Dark mode for every website. Take care of your eyes, use dark theme for night and daily browsing.";
        license = licenses.mit;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "storage"
          "tabs"
          "theme"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildFirefoxXpiAddon {
      pname = "keepassxc-browser";
      version = "1.9.11";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4628286/keepassxc_browser-1.9.11.xpi";
      sha256 = "bee523ac8d968d36ae3ae317b12b1b2bbe85e2c6f5b9ddb0fb822c2d90af6139";
      meta = with lib;
      {
        homepage = "https://keepassxc.org/";
        description = "Official browser plugin for the KeePassXC password manager (https://keepassxc.org).";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "clipboardWrite"
          "contextMenus"
          "cookies"
          "nativeMessaging"
          "notifications"
          "storage"
          "tabs"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "https://*/*"
          "http://*/*"
          "https://api.github.com/"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "libredirect" = buildFirefoxXpiAddon {
      pname = "libredirect";
      version = "3.2.0";
      addonId = "7esoorv3@alefvanoon.anonaddy.me";
      url = "https://addons.mozilla.org/firefox/downloads/file/4522826/libredirect-3.2.0.xpi";
      sha256 = "ba4cf8fe97275d7082fea085a09796481122845455df1af524a7210fff3ecf3c";
      meta = with lib;
      {
        homepage = "https://libredirect.github.io";
        description = "Redirects YouTube, Twitter, TikTok... requests to alternative privacy friendly frontends.";
        license = licenses.gpl3;
        mozPermissions = [
          "webRequest"
          "webRequestBlocking"
          "storage"
          "clipboardWrite"
          "contextMenus"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "protondb-for-steam" = buildFirefoxXpiAddon {
      pname = "protondb-for-steam";
      version = "2.3.0";
      addonId = "{30280527-c46c-4e03-bb16-2e3ed94fa57c}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4490230/protondb_for_steam-2.3.0.xpi";
      sha256 = "e5ab8d594cd71c7a345a6694620ad9c4a3abb97161a191b72484f5b934ba96c5";
      meta = with lib;
      {
        homepage = "https://github.com/tryton-vanmeer/ProtonDB-for-Steam#protondb-for-steam";
        description = "Shows ratings from protondb.com on Steam";
        license = licenses.lgpl3;
        mozPermissions = [
          "https://www.protondb.com/*"
          "https://store.steampowered.com/app/*"
          "https://store.steampowered.com/wishlist/*"
          "https://steamcommunity.com/id/*/games"
          "https://steamcommunity.com/id/*/games?tab=*"
        ];
        platforms = platforms.all;
      };
    };
    "redirectnixwiki" = buildFirefoxXpiAddon {
      pname = "redirectnixwiki";
      version = "1.0";
      addonId = "redirect-nix-wiki@undesided.me";
      url = "https://addons.mozilla.org/firefox/downloads/file/4373121/redirectnixwiki-1.0.xpi";
      sha256 = "ca09df5c8bf96d6ed34ee8753decef188099ab77c2490f86ee172545236fd03f";
      meta = with lib;
      {
        homepage = "https://gitlab.com/utzuro/browser-plugins/-/tree/main/redirectNixWiki";
        description = "Redirects old \"nixos.wiki\" to the official \"wiki.nixos.org\".";
        license = licenses.mit;
        mozPermissions = [
          "webRequest"
          "webRequestBlocking"
          "*://nixos.wiki/*"
        ];
        platforms = platforms.all;
      };
    };
    "sponsorblock" = buildFirefoxXpiAddon {
      pname = "sponsorblock";
      version = "6.1.2";
      addonId = "sponsorBlocker@ajay.app";
      url = "https://addons.mozilla.org/firefox/downloads/file/4644570/sponsorblock-6.1.2.xpi";
      sha256 = "598f66c9eb6bbab2bd5f87376b632a5860f442d3694e233610f5b37f8b6e3f10";
      meta = with lib;
      {
        homepage = "https://sponsor.ajay.app";
        description = "Easily skip YouTube video sponsors. When you visit a YouTube video, the extension will check the database for reported sponsors and automatically skip known sponsors. You can also report sponsors in videos. Other browsers: https://sponsor.ajay.app";
        license = licenses.lgpl3;
        mozPermissions = [
          "storage"
          "scripting"
          "unlimitedStorage"
          "https://sponsor.ajay.app/*"
          "https://*.youtube.com/*"
          "https://www.youtube-nocookie.com/embed/*"
        ];
        platforms = platforms.all;
      };
    };
    "steam-database" = buildFirefoxXpiAddon {
      pname = "steam-database";
      version = "4.31";
      addonId = "firefox-extension@steamdb.info";
      url = "https://addons.mozilla.org/firefox/downloads/file/4648167/steam_database-4.31.xpi";
      sha256 = "4c7ee23e77fef583d2adf7de883f7df2ecd719dfbe716d96226929087a80c156";
      meta = with lib;
      {
        homepage = "https://steamdb.info/";
        description = "Adds SteamDB links and new features on the Steam store and community. View lowest game prices and stats.";
        license = licenses.bsd2;
        mozPermissions = [
          "storage"
          "https://steamdb.info/*"
          "https://store.steampowered.com/*"
          "https://steamcommunity.com/*"
          "https://store.steampowered.com/app/*"
          "https://store.steampowered.com/news/app/*"
          "https://store.steampowered.com/account/licenses*"
          "https://store.steampowered.com/account/registerkey*"
          "https://store.steampowered.com/sub/*"
          "https://store.steampowered.com/bundle/*"
          "https://store.steampowered.com/widget/*"
          "https://store.steampowered.com/app/*/agecheck"
          "https://store.steampowered.com/agecheck/*"
          "https://store.steampowered.com/explore*"
          "https://steamcommunity.com/app/*"
          "https://steamcommunity.com/sharedfiles/filedetails*"
          "https://steamcommunity.com/workshop/filedetails*"
          "https://steamcommunity.com/workshop/browse*"
          "https://steamcommunity.com/workshop/discussions*"
          "https://steamcommunity.com/id/*"
          "https://steamcommunity.com/profiles/*"
          "https://steamcommunity.com/id/*/inventory*"
          "https://steamcommunity.com/profiles/*/inventory*"
          "https://steamcommunity.com/id/*/stats*"
          "https://steamcommunity.com/profiles/*/stats*"
          "https://steamcommunity.com/id/*/stats/CSGO*"
          "https://steamcommunity.com/profiles/*/stats/CSGO*"
          "https://steamcommunity.com/stats/*/achievements*"
          "https://steamcommunity.com/tradeoffer/*"
          "https://steamcommunity.com/id/*/recommended/*"
          "https://steamcommunity.com/profiles/*/recommended/*"
          "https://steamcommunity.com/id/*/badges*"
          "https://steamcommunity.com/profiles/*/badges*"
          "https://steamcommunity.com/id/*/gamecards/*"
          "https://steamcommunity.com/profiles/*/gamecards/*"
          "https://steamcommunity.com/market/multibuy*"
          "https://steamcommunity.com/market/*"
          "https://steamcommunity.com/games/*"
          "https://steamcommunity.com/sharedfiles/*"
          "https://steamcommunity.com/workshop/*"
          "https://steamcommunity.com/linkfilter/*"
          "https://steamcommunity.com/tradingcards/boostercreator*"
        ];
        platforms = platforms.all;
      };
    };
    "styl-us" = buildFirefoxXpiAddon {
      pname = "styl-us";
      version = "2.3.17";
      addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4611621/styl_us-2.3.17.xpi";
      sha256 = "ad952d5fc19bd36d0fd2aecc7d4b4ebf7add538faecab79ad96e1db631857667";
      meta = with lib;
      {
        homepage = "https://add0n.com/stylus.html";
        description = "Redesign your favorite websites with Stylus, an actively developed and community driven userstyles manager. Easily install custom themes from popular online repositories, or create, edit, and manage your own personalized CSS stylesheets.";
        license = licenses.gpl3;
        mozPermissions = [
          "alarms"
          "contextMenus"
          "storage"
          "tabs"
          "unlimitedStorage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
          "https://userstyles.org/*"
        ];
        platforms = platforms.all;
      };
    };
    "torrserver-adder" = buildFirefoxXpiAddon {
      pname = "torrserver-adder";
      version = "2.0.5";
      addonId = "84z74tXJKt8OUrTD@TSA";
      url = "https://addons.mozilla.org/firefox/downloads/file/4264581/torrserver_adder-2.0.5.xpi";
      sha256 = "6783c13fe423c14fbf9dd23ea3232167dc78eeb298594ab802aa9a7b094fb365";
      meta = with lib;
      {
        homepage = "https://github.com/Noperkot/TorrServerAdder";
        description = "Allows you to add torrents to TorrServer and play them using the system media player";
        license = licenses.mpl20;
        mozPermissions = [
          "http://*/*"
          "https://*/*"
          "contextMenus"
          "downloads"
          "storage"
          "tabs"
          "webRequest"
          "webRequestBlocking"
        ];
        platforms = platforms.all;
      };
    };
    "traduzir-paginas-web" = buildFirefoxXpiAddon {
      pname = "traduzir-paginas-web";
      version = "10.1.1.1";
      addonId = "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4455681/traduzir_paginas_web-10.1.1.1.xpi";
      sha256 = "dc94a7efac63468f7d34a74bedf5c8b360a67c99d213bb5b1a1d55d911797782";
      meta = with lib;
      {
        description = "Translate your page in real time using Google, Bing or Yandex.\nIt is not necessary to open new tabs.";
        license = licenses.mpl20;
        mozPermissions = [
          "<all_urls>"
          "storage"
          "activeTab"
          "contextMenus"
          "webRequest"
          "https://www.deepl.com/*/translator*"
        ];
        platforms = platforms.all;
      };
    };
    "ublock-origin" = buildFirefoxXpiAddon {
      pname = "ublock-origin";
      version = "1.68.0";
      addonId = "uBlock0@raymondhill.net";
      url = "https://addons.mozilla.org/firefox/downloads/file/4629131/ublock_origin-1.68.0.xpi";
      sha256 = "5caf4abda494018841222a12156919bbdd8cad82a783c38c36b22dd642704315";
      meta = with lib;
      {
        homepage = "https://github.com/gorhill/uBlock#ublock-origin";
        description = "Finally, an efficient wide-spectrum content blocker. Easy on CPU and memory.";
        license = licenses.gpl3;
        mozPermissions = [
          "alarms"
          "dns"
          "menus"
          "privacy"
          "storage"
          "tabs"
          "unlimitedStorage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
          "http://*/*"
          "https://*/*"
          "file://*/*"
          "https://easylist.to/*"
          "https://*.fanboy.co.nz/*"
          "https://filterlists.com/*"
          "https://forums.lanik.us/*"
          "https://github.com/*"
          "https://*.github.io/*"
          "https://github.com/uBlockOrigin/*"
          "https://ublockorigin.github.io/*"
          "https://*.reddit.com/r/uBlockOrigin/*"
        ];
        platforms = platforms.all;
      };
    };
    "youtube-addon" = buildFirefoxXpiAddon {
      pname = "youtube-addon";
      version = "4.1400";
      addonId = "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4636627/youtube_addon-4.1400.xpi";
      sha256 = "f47e6df9018b7d78977b79a789a4dcdefbd6a0470f4c6c65cc4c5e50cb543543";
      meta = with lib;
      {
        homepage = "https://github.com/code4charity/YouTube-Extension/";
        description = "Youtube Extension. Powerful but lightweight. Enrich your Youtube and content selection. Make YouTube tidy and smart! (Layout, Filters, Shortcuts, Playlist)";
        mozPermissions = [
          "contextMenus"
          "storage"
          "https://www.youtube.com/*"
          "https://m.youtube.com/*"
        ];
        platforms = platforms.all;
      };
    };
  }