{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  persist.dirs = [ "/etc/nixos" ];

  environment = with pkgs; {
    systemPackages = [ hydra-check ];
  };

  nix = {
    package = pkgs.nix;

    registry =
      (mapAttrs (
        _: v: {
          flake = v;
        }
      ))
        (filterAttrs (_: v: isType "flake" v) inputs);

    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      download-buffer-size = (512 * 1000000);

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        system.userName
        "@wheel"
      ];

      substituters = [
        "https://niri.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://unmojang.cachix.org"
        "https://winapps.cachix.org"
        "https://xache.cachix.org"
      ];

      trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "unmojang.cachix.org-1:OfHnbBNduZ6Smx9oNbLFbYyvOWSoxb2uPcnXPj4EDQY="
        "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g="
        "xache.cachix.org-1:InoMKnvFvDh+J5gFNHN1mmUONxvYJqFImLJY8/bl9YA="
      ];
    };

    # INFO: from secret as
    #
    # > githubToken.age | githubToken.yaml
    # access-tokens = github.com=23ac...b289
    extraOptions = ''
      !include ${config.agenix.github}
    '';
  };

  nixpkgs = {
    hostPlatform = mkDefault system.platform;

    overlays = with inputs; [
      fjordlauncher.overlays.default
      niri.overlays.niri
      nur.overlays.default

      (
        final: prev:
        self.packages.${system.platform}
        // winapps.packages."${system.platform}"
        // {
          old = import nixpkgs-old {
            inherit (prev)
              system
              config
              ;
          };

          _24 = import nixpkgs-24 {
            inherit (prev)
              system
              config
              ;
          };

          _25 = import nixpkgs-25 {
            inherit (prev)
              system
              config
              ;
          };

          agenix = inputs.agenix.packages.${pkgs.system}.default;
          anipy-cli = anipy.packages.${system.platform}.default;

          cursors = cursors.packages.${system.platform};
          gaming = gaming.packages.${system.platform};
          spicetify = spicetify.legacyPackages.${system.platform};
        }
      )
    ];

    config = {
      allowBroken = true;
      allowInsecure = true;
      allowUnfree = true;
    };
  };

  system.stateVersion = system.version;
}
