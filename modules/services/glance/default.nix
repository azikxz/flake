{
  lib,
  config,
  ...
}:

with lib;
let
  # cause stylix have'nt hsl colors
  # i snatched (спиздил) it from github
  mkHsl =
    (import ./mkHsl.nix {
      inherit
        lib
        config
        ;
    }).init;
in
# INFO:
# very customizable dashboard
# have many...many...many optins
# i'll update it often

mkIf (mac "pcRyazenka") {
  services.glance = {
    enable = true;
    openFirewall = true;

    settings = {
      # not 8080 caouse qbittorrent
      server.port = 5678;

      branding = {
        app-name = "Glance - homepage";
        logo-text = "󱄅";

        app-icon-url = "https://github.com/glanceapp/glance/blob/36d5ae023f95efd10f7d53d6fe4818b170f6e92f/docs/logo.png";
        favicon-url = "https://github.com/glanceapp/glance/blob/36d5ae023f95efd10f7d53d6fe4818b170f6e92f/docs/logo.png";
        # just an glance favicon

        app-background-color = config.lib.stylix.colors.withHashtag.base00;
        hide-footer = true;
      };

      theme = mkForce {
        contrast-multiplier = 1.0;
        background-color = mkHsl "base00";
        primary-color = mkHsl "base05";
        positive-color = mkHsl "base0A";
        negative-color = mkHsl "base04";
      };

      pages = [
        {
          name = "Home";

          hide-desktop-navigation = true;

          head-widgets = [
            {
              type = "markets";
              markets = [
                {
                  symbol = "BTC-USD";
                  name = "Bitcoin";
                  chart-link = "https://www.tradingview.com/chart/?symbol=INDEX:BTCUSD";
                }
                {
                  symbol = "SOL-USD";
                  name = "Solana";
                  chart-link = "https://www.tradingview.com/chart/?symbol=INDEX:SOLUSD";
                }
                {
                  symbol = "ETH-USD";
                  name = "Ethereum";
                  chart-link = "https://www.tradingview.com/chart/?symbol=INDEX:ETHUSD";
                }
              ];
            }
          ];

          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      label = "Moscow";
                      timezone = "Europe/Moscow";
                    }

                    {
                      label = "Tashkent";
                      timezone = "Asia/Tashkent";
                    }

                    {
                      label = "Tokyo";
                      timezone = "Asia/Tokyo";
                    }

                    {
                      label = "New York";
                      timezone = "America/New_York";
                    }
                  ];
                }

                {
                  type = "weather";
                  location = "Tynda, Russia";
                  hour-format = "24h";
                }

                {
                  type = "calendar";
                }
              ];
            }

            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "https://4get.nadeko.net/web?s={QUERY}";
                  # 4get cause if anonimus, so be anonimus
                  # soon i will host 4get on my own

                  new-tab = true;
                  autofocus = true;

                  bangs = [
                    {
                      title = "YouTube";
                      shortcut = "!yt";
                      url = "https://www.youtube.com/results?search_query={QUERY}";
                    }

                    {
                      title = "Rutracker";
                      shortcut = "!rt";
                      url = "https://rutracker.org/forum/tracker.php?nm={QUERY}";
                    }

                    {
                      title = "Nitter";
                      shortcut = "!nt";
                      url = "https://nitter.net/search?q={QUERY}";
                    }

                    {
                      title = "Binternet";
                      shortcut = "!bn";
                      url = "https://binternet.private.coffee/search.php?q={QUERY}";
                    }

                    {
                      title = "PixivFE";
                      shortcut = "!pi";
                      url = "http://pixivfe.ducks.party/search?name={QUERY}";
                    }

                    {
                      title = "Anilist (manga)";
                      shortcut = "!alm";
                      url = "https://anilist.co/search/manga?search={QUERY}";
                    }

                    {
                      title = "Anilist (anime)";
                      shortcut = "!ala";
                      url = "https://anilist.co/search/anime?search={QUERY}";
                    }

                    {
                      title = "Intellectual";
                      shortcut = "!in";
                      url = "http://intellectual.ducks.party/search?q={QUERY}";
                    }
                  ];
                }

                {
                  type = "bookmarks";
                  groups =
                    let
                      https = "https://";

                      # GREAT OVER-ENGINEERING
                      mk =
                        address: args:
                        args
                        // {
                          url = https + address;
                          icon = https + args.icon;
                        };
                    in
                    with config.lib.stylix.colors;
                    [
                      {
                        title = "";
                        same-tab = true;
                        links = [
                          (mk "mail.google.com" {
                            title = "Gmail";
                            icon = "icons.ly/gmail/${base08}";
                          })

                          (mk "youtube.com" {
                            title = "Youtube";
                            icon = "icons.ly/youtube/${base09}";
                          })

                          (mk "github.com" {
                            title = "Github";
                            icon = "icons.ly/github/${base0F}";
                          })

                          (mk "chat.deepseek.com" {
                            title = "Deepseek";
                            icon = "icons.ly/chatbot/${base0D}";
                          })

                          (mk "claude.ai" {
                            title = "Claude AI";
                            icon = "icons.ly/claude/${base09}";
                          })
                        ];
                      }

                      {
                        title = "NixOS useful...";
                        same-tab = true;
                        color = mkHsl "base0D";
                        links = [
                          (mk "search.nixos.org/options?channel=unstable" {
                            title = "NixOS Search";
                            icon = "icons.ly/nixos/${base0D}";
                          })

                          (mk "home-manager-options.extranix.com/?query=&release=master" {
                            title = "Home-Manager Search";
                            icon = "icons.ly/nixos/${base0C}";
                          })

                          (mk "wiki.nixos.org" {
                            title = "NixOS Wiki";
                            icon = "icons.ly/nixos/${base0E}";
                          })
                        ];
                      }

                      {
                        title = "Social...";
                        same-tab = true;
                        color = mkHsl "base0B";
                        links = [
                          (mk "anilist.co" {
                            title = "Anilist";
                            icon = "icons.ly/anilist/${base0D}";
                          })

                          (mk "anichart.net" {
                            title = "Anichart";
                            icon = "icons.ly/anilist/${base0C}";
                          })

                          (mk "binternet.private.coffee" {
                            title = "Binternet";
                            icon = "icons.ly/pinterest/${base08}";
                          })

                          (mk "simplytranslate.ducks.party" {
                            title = "Translate";
                            icon = "icons.ly/googletranslate/${base0D}";
                          })

                          (mk "intellectual.ducks.party" {
                            title = "Intellectual";
                            icon = "icons.ly/genius/${base0A}";
                          })
                        ];
                      }

                      {
                        title = "Games...";
                        same-tab = true;
                        color = mkHsl "base08";
                        links = [
                          (mk "modrinth.com" {
                            title = "Modrinth";
                            icon = "icons.ly/modrinth/${base0B}";
                          })

                          (mk "ru.minecraft.wiki" {
                            title = "Minecraft Wiki";
                            icon = "icons.ly/wikipedia/${base0C}";
                          })

                          (mk "steamdb.info" {
                            title = "Steam DB";
                            icon = "icons.ly/steamdb/${base0D}";
                          })

                          (mk "protondb.com" {
                            title = "Proton DB";
                            icon = "icons.ly/protondb/${base0D}";
                          })
                        ];
                      }
                    ];
                }

                {
                  type = "hacker-news";
                }

                {
                  type = "lobsters";
                }
              ];
            }

            {
              size = "small";
              widgets = [
                (
                  let
                    isRu = true;
                  in
                  {
                    type = "custom-api";
                    title = "Steam Specials";
                    cache = "12h";

                    # replace cc=ru on cc=us for change currency to USD
                    url = "https://store.steampowered.com/api/featuredcategories?cc=${if isRu then "ru" else "us"}";
                    template = ''
                      <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                      {{ range .JSON.Array "specials.items" }}
                        <li>
                          <a class="size-h4 color-highlight block text-truncate" href="https://store.steampowered.com/app/{{ .Int "id" }}/">{{ .String "name" }}</a>
                          <ul class="list-horizontal-text">
                            <li>{{ div (.Int "final_price" | toFloat) 100 | printf "${
                              if isRu then "%.2f ₽" else "%.2f $"
                            }" }}</li>
                            {{ $discount := .Int "discount_percent" }}
                            <li{{ if ge $discount 40 }} class="color-positive"{{ end }}>{{ $discount }}%</li>
                          </ul>
                        </li>
                      {{ end }}
                      </ul>
                    '';
                  }
                )

                {
                  type = "custom-api";
                  title = "Random Fact";
                  cache = "2h";

                  # u can use 2 variants of facts:
                  # > https://uselessfacts.jsph.pl/api/v2/facts/random
                  # > https://uselessfacts.jsph.pl/api/v2/facts/today
                  url = "https://uselessfacts.jsph.pl/api/v2/facts/random";
                  template = ''
                    <p class="size-h4 color-paragraph">{{ .JSON.String "text" }}</p>
                  '';
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
