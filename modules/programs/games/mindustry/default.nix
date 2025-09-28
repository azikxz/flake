{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: factory maker

(mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Mindustry" ];

  environment.systemPackages = [ pkgs.mindustry-wayland ];

  hm.xdg.dataFile =
    (
      mods:
      listToAttrs (
        map (
          mod:
          let
            modName = removeSuffix ".jar" (baseNameOf mod.url) + ".zip";
          in
          {
            name = "Mindustry/mods/${modName}";
            value.source = pkgs.runCommand modName { } ''
              cp ${
                pkgs.fetchurl {
                  inherit (mod)
                    url
                    sha256
                    ;
                }
              } $out
            '';
          }
        ) mods
      )
    )
      # {
      #   url = "...";
      #   sha256 = "..."; # nix store prefetch-file url
      # }
      [ ];
})
