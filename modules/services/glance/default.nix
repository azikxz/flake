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
                }

                {
                  type = "calendar";
                }

                {
                  type = "weather";
                  location = "Tynda, Russia";
                  hour-format = "24h";
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

                  bangs = [
                    {
                      title = "YouTube";
                      shortcut = "!yt";
                      url = "https://www.youtube.com/results?search_query={QUERY}";
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

                          (mk "github.com" {
                            title = "Github";
                            icon = "icons.ly/github/${base0F}";
                          })

                          (mk "youtube.com" {
                            title = "Youtube";
                            icon = "icons.ly/youtube/${base09}";
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
          ];
        }
      ];
    };
  };
}
