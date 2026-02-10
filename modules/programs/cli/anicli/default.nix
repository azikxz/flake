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
#
# WARN:
# replaced to rezka-fzf

mkIf false (mkMerge [
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
])
