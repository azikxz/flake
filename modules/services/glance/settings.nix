{
  lib,
  config,

  isRu,
  mkHsl,
  ...
}:

with lib;
let
  token = "\${GITHUB}";
in

{
  # not 8080 caouse qbittorrent
  server = {
    port = 5678;
    host = "0.0.0.0";
  };

  branding = {
    app-name = "Glance - homepage";
    logo-text = "󱄅";

    app-background-color = config.lib.stylix.colors.withHashtag.base00;
    hide-footer = true;
  };

  theme = mkForce {
    contrast-multiplier = 1.0;
    background-color = mkHsl "base00";
    primary-color = mkHsl "base05";
    positive-color = mkHsl "base0A";
    negative-color = mkHsl "base08";
  };

  pages = [
    {
      name = "Home";

      show-mobile-header = true;

      head-widgets = [
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
              ];
            }

            {
              type = "weather";
              location = "Tynda, Russia";
              hide-location = true;
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
              type = "bookmarks";
              hide-arrow = true;
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
                    title = "General links...";
                    same-tab = true;
                    color = mkHsl "base08";
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
                ];
            }

            {
              type = "split-column";
              widgets = [
                {
                  type = "hacker-news";
                  collapse-after = 3;
                }
                {
                  type = "lobsters";
                  collapse-after = 3;
                }
              ];
            }
          ];
        }

        {
          size = "small";
          widgets = [
            {
              type = "group";
              widgets = [
                {
                  type = "custom-api";
                  title = "Steam";
                  cache = "12h";

                  # replace cc=ru on cc=us for change currency to USD
                  url = "https://store.steampowered.com/api/featuredcategories?cc=${if isRu then "ru" else "us"}";
                  template = ''
                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="5"> {{ range .JSON.Array "specials.items" }}
                    <li> <a class="size-h4 color-highlight block text-truncate" href="https://store.steampowered.com/app/{{ .Int "id" }}/">{{ .String "name" }}</a> <ul class="list-horizontal-text">
                      <li>{{ div (.Int "final_price" | toFloat) 100 | printf "${
                        if isRu then "%.0f₽" else "%.0f$"
                      }" }}</li>
                      {{ $discount := .Int "discount_percent" }}
                      <li><del style="opacity:0.6">{{ div (.Int "original_price" | toFloat) 100 | printf "${
                        if isRu then "%.0f₽" else "%.0f$"
                      }" }}</del></li>
                      {{ $discount := .Int "discount_percent" }}
                      <li{{ if ge $discount 40 }} class="color-positive"{{ end }}>{{ $discount }}%</li>
                    </ul> </li> {{ end }} </ul>
                  '';
                }

                {
                  type = "custom-api";
                  title = "EGS";
                  cache = "6h";

                  url = "https://store-site-backend-static.ak.epicgames.com/freeGamesPromotions?locale=en&country=${if isRu then "RU" else "US"}";
                  # modified module for fetch epic games discounts
                  template = ''
                    <div>
                      {{ if eq .Response.StatusCode 200 }}
                        <div class="horizontal-cards-2">
                          {{ range .JSON.Array "data.Catalog.searchStore.elements" }}
                            {{ $price := .String "price.totalPrice.discountPrice" }}
                            {{ $originalPrice := .String "price.totalPrice.originalPrice" }}
                            {{ $hasPromo := gt (len (.Array "promotions.promotionalOffers")) 0 }}
                            {{ if and $hasPromo (eq $price "0") }}
                              {{ $gamePage := .String "productSlug" }}
                              {{ if gt (len (.Array "offerMappings")) 0 }}
                                {{ $gamePage = .String "offerMappings.0.pageSlug" }}
                              {{ end }}
                              <div class="card">
                                <div class="card-content">
                                  <a href="https://store.epicgames.com/${
                                    if isRu then "ru" else "en-US"
                                  }/p/{{ $gamePage }}" target="_blank">
                                    <span class="size-h4 color-primary">{{ .String "title" }}</span>
                                  </a>
                                  <br>
                                  <span class="size-h5 color-paragraph">
                                    {{ if $hasPromo }}
                                      {{ $promotions := .Array "promotions.promotionalOffers" }}
                                      {{ if gt (len $promotions) 0 }}
                                        {{ $firstPromo := index $promotions 0 }}
                                        {{ $offers := $firstPromo.Array "promotionalOffers" }}
                                        {{ if gt (len $offers) 0 }}
                                          {{ $firstOffer := index $offers 0 }}
                                          {{ $startDate := $firstOffer.String "startDate" }}
                                          {{ $endDate := $firstOffer.String "endDate" }}
                                          {{ slice $startDate 8 10 }}.{{ slice $startDate 5 7 }}.{{ slice $startDate 0 4 }} - {{ slice $endDate 8 10 }}.{{ slice $endDate 5 7 }}.{{ slice $endDate 0 4 }}
                                          {{ if ne $originalPrice "0" }}
                                            <span class="size-h5"> • <del style="opacity:0.6">
                                              {{ div (.Int "price.totalPrice.originalPrice" | toFloat) 100 | printf "${
                                                if isRu then "%.0f₽" else "%.0f$"
                                              }" }}
                                            </del></span>
                                          {{ end }}
                                        {{ else }}
                                          free this week!
                                        {{ end }}
                                      {{ else }}
                                        free this week!
                                      {{ end }}
                                    {{ end }}
                                  </span>
                                </div>
                              </div>
                            {{ end }}
                          {{ end }}
                        </div>
                      {{ else }}
                        <p class="color-negative">Error fetching Epic Games data!!!</p>
                      {{ end }}
                    </div>
                  '';
                }
              ];
            }

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

    {
      name = "News and web info";

      columns = [
        {
          size = "small";
          widgets = [
            {
              type = "server-stats";
              servers = [
                {
                  type = "local";
                  name = "Services";
                }
              ];
            }

            {
              type = "releases";
              repositories = [
                "Alexays/Waybar"
                "Anuken/Mindustry"
                "Anuken/MindustryBuilds"
                "artemsen/swayimg"
                "AyuGram/AyuGramDesktop"
                "bol-van/zapret"
                "derrod/legendary"
                "dundee/gdu"
                "ebkr/r2modmanPlus"
                "fish-shell/fish-shell"
                "helix-editor/helix"
                "hyprwm/Hyprland"
                "keepassxreboot/keepassxc"
                "lutris/lutris"
                "mindstorm38/portablemc"
                "mpv-player/mpv"
                "PrismLauncher/PrismLauncher"
                "qbittorrent/qBittorrent"
                "qutebrowser/qutebrowser"
                "sxyazi/yazi"
                "syncthing/syncthing"
                "talwat/lowfi"
                "TDesktop-x64/tdesktop"
                "unmojang/FjordLauncher"
                "Vencord/Vesktop"
                "YaLTeR/niri"
                "YouROK/TorrServer"
              ];

              inherit
                token
                ;
            }
          ];
        }

        {
          size = "full";
          widgets = [
            {
              type = "reddit";
              subreddit = "nixos";
              style = "horizontal-cards";
              collapse-after = 15;
            }
          ];
        }
      ];
    }

    {
      name = "Games and info";

      columns = [
        {
          size = "full";
          widgets = [
            {
              type = "reddit";
              subreddit = "nixos";
              style = "horizontal-cards";
              collapse-after = 15;
            }
          ];
        }
      ];
    }
  ];
}
