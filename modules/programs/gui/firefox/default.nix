{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  settings = import ./settings.nix {
    inherit
      lib
      config
      ;
  };
in
# INFO:
# one of the best browsers ever
#
# WARN:
# update extensions everytime when u remember it

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.librewolf = {
    enable = true;

    nativeMessagingHosts = [ ] ++ (optionals config.hm.programs.keepassxc.enable [ pkgs.keepassxc ]);

    inherit (settings)
      policies
      ;

    profiles.${system.userName} = {
      settings = settings.profile;

      search = {
        force = true;

        default = "google";
        engines = {
          "google" = {
            urls = [
              {
                template = "https://google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = pkgs.fetchurl {
              url = "https://www.google.com/favicon.ico";
              sha256 = "sha256-baViCIAVljQhPhl/r8od3gJyFTvj5FkIGFM/q40EB3A=";
            };
          };
        };
      };

      extensions = {
        force = true;

        settings = settings.extensions;
        packages = import ./extensions.nix {
          inherit
            pkgs
            lib
            config
            ;
        };
      };

      bookmarks = {
        meta.maintainers = [ maintainers.azikxz ];
        settings = settings.bookmarks;
        force = true;
      };

      userContent =
        with config.lib.stylix.colors.withHashtag;
        # css
        ''
          /* background setting */
          @-moz-document ${
            concatStringsSep ", " [
              ''url("about:home")''
              ''url("about:newtab")''
            ]
          } {
            body {
              background-image: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0)),
                url("file://${inputs.wallpapers."moonWithSputnik"}") !important;
              background-position: center !important;
              background-repeat: no-repeat !important;
              background-attachment: fixed !important;
              backdrop-filter: blur(4px) saturate(180%) brightness(0.7) !important;
            }
          }

          /* searchbar colorize */
          .search-wrapper .search-handoff-button, .search-wrapper input {
          	background: ${base01} !important;
          	border-radius: 96px !important;
          	color: ${base05} !important;
          }

          /* hide right-bottom button */
          .personalizeButtonWrapper { display: none !important; }
        '';

      extraConfig = concatStringsSep "\n" (
        map (f: readFile f) [
          "${inputs.betterfox}/Fastfox.js"
          "${inputs.betterfox}/Peskyfox.js"
          "${inputs.betterfox}/Securefox.js"
          "${inputs.betterfox}/Smoothfox.js"
          "${inputs.betterfox}/user.js"
        ]
      );
    };
  };

  hmMime = mkMime {
    "spotify.desktop" = [
      "x-scheme-handler/spotify"
      "x-scheme-handler/https"
    ];

    "librewolf.desktop" = [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/chrome"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];
  };
}
