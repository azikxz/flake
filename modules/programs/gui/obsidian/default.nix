{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".config/obsidian" ];

  hm.programs.obsidian = {
    enable = true;
    package = pkgs.obsidian.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          wrapProgram $out/bin/${oldAttrs.pname} \
            --add-flags "--ozone-platform=wayland --ozone-platform-hint=auto"
        '';
    });

    vaults =
      mapAttrs'
        (
          name: _:
          nameValuePair ((name: removeSuffix ".nix" name) name) (
            import (./vaults + "/${name}") {
              inherit
                pkgs
                lib
                config
                ;
            }
          )
        )
        (filterAttrs (name: type: type == "regular" && hasSuffix ".nix" name) (builtins.readDir ./vaults));
  };

  # hm.xdg.configFile."obsidian/obsidian.json".source = mkForce (
  #   (pkgs.formats.json { }).generate "obsidian.json" (
  #     {
  #       vaults = listToAttrs (
  #         map (vault: {
  #           name = builtins.hashString "md5" vault.target;
  #           value =
  #             {
  #               path = "${config.hm.home.homeDirectory}/${vault.target}";
  #             }
  #             // (attrsets.optionalAttrs ((length vaults) == 1) {
  #               open = true;
  #             });
  #         }) (filter (vault: vault.enable == true) (attrValues cfg.vaults))
  #       );
  #       updateDisabled = true;
  #     }
  #     // {
  #       frame = "native";
  #     }
  #   )
  # );
}
