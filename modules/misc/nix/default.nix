{
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;

{
  environment.systemPackages = [ pkgs.hydra-check ];

  nix = {
    package = pkgs.nix;

    settings = {
      warn-dirty = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        system.userName
        "@wheel"
      ];

      substituters = [
        "https://cache.garnix.io"
        "https://chaotic-nyx.cachix.org"
        "https://cosmic.cachix.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://niri.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://nyx.chaotic.cx"
        "https://xache.cachix.org"
      ];

      trusted-public-keys = [
        ".cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "xache.cachix.org-1:InoMKnvFvDh+J5gFNHN1mmUONxvYJqFImLJY8/bl9YA="
      ];
    };
  };

  nixpkgs = {
    hostPlatform = mkDefault system.platform;

    overlays = with inputs; [
      niri.overlays.niri
      nur.overlays.default

      (
        final: prev:
        nixages.packages."x86_64-linux"
        // {
          stable = import nixpkgs-stable {
            inherit (prev)
              system
              config
              ;
          };
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
