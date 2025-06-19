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

    vaults = {
      notes = import ./vaults/notes {
        inherit
          pkgs
          lib
          config
          ;
      };
    };
  };
}
