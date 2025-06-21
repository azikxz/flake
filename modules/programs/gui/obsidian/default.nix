{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf true {
  persist.user.dirs = [ ".config/obsidian" ];

  hm.programs.obsidian = {
    enable = true;
    package = pkgs.obsidian.overrideAttrs (oldAttrs: {
      installPhase =
        oldAttrs.installPhase
        + ''
          wrapProgram $out/bin/obsidian \
            --add-flags "--ozone-platform=wayland --ozone-platform-hint=auto"
        '';
    });

    vaults = mapAttrs (
      name: _:
      import (./vaults + "/${name}/main.nix") {
        inherit
          pkgs
          lib
          config
          ;
      }
    ) (filterAttrs (name: type: type == "directory") (builtins.readDir ./vaults));
  };
}
