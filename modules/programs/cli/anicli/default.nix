{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  toml = pkgs.formats.toml { };
in
# INFO:
# anime scrappers/watchers

mkIf (mac "pcRyazenka" || mac "thinkpadT14") (mkMerge [
  {
    # INFO: usage
    # anicli -> anicli-ru -q 1440
    #
    # WARN: to use anilib auth follow this
    # https://github.com/vypivshiy/anicli-api/issues/42#issuecomment-2889017544
    hmPackages = [ pkgs.anicliru ];

    nixpkgs.overlays = [
      (
        final: prev: with prev.lib; {
          anicliru = prev.writeShellScriptBin "anicliru" ''
            ${getExe pkgs.anicli-ru} -q 1080 --header-file ${config.sopsnix."tokens/anilibme"} "$@"
          '';
        }
      )
    ];
  }

  {
    # INFO:
    # providers
    #   allanime aniwatch yugen hdrezka aniworld crunchyroll
    #
    # token for jerry taken from
    # https://anilist.co/api/v2/oauth/authorize?client_id=9857&response_type=token
    persist.user.files = [ ".local/share/jerry/anilist_user_id.txt" ];

    hm = {
      programs.jerry = {
        # enable = true;

        config = {
          provider = "hdrezka";

          manga_format = "pdf";
          manga_opener = "zathura";

          image_preview = "true";
          score_on_completion = "true";
          show_adult_content = true;

          sub_or_dub = "sub";
          subs_language = "russian";
        };
      };

      xdg.dataFile = {
        "jerry/anilist_token.txt".source = mkSymlink config.sopsnix."tokens/jerry";
      };
    };
  }

  {
    hmPackages = [ pkgs.anipy-cli ];
  }

  {
    # INFO: very cool (best imho) anime watcher
    # with anilist support
    hmPackages = [ pkgs.viu ];

    hm.xdg.configFile = {
      "viu/config.toml".source = toml.generate "viu-config" (
        import ./viuConfig.nix {
          inherit
            lib
            config
            ;
        }
      );

      "viu/auth.json".source = mkSymlink config.sopsnix."tokens/viu";
    };
  }

  {
    # hmPackages = [ pkgs.curd ];
  }
])
