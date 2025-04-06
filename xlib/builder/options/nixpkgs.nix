{
  self,
  inputs,
  pkgs,
  ...
}:

{
  # overlays, nix subsitutters and keys
  nix = {
    subs = [
      "https://nix-gaming.cachix.org" # NIX GAMING
      "https://chaotic-nyx.cachix.org" # CHAOTIC
      "https://helix.cachix.org" # HELIX
      "https://xache.cachix.org" # MY OWN
      "https://cache.garnix.io" # AYUGRAM
      "https://nyx.chaotic.cx" # NYX
      #
      "https://hyprland.cachix.org" # HYPRLAND
      "https://cosmic.cachix.org" # COSMIC
      "https://niri.cachix.org" # NIRI
    ];
    keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" # NIX GAMING
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" # CHAOTIC
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" # HELIX
      "xache.cachix.org-1:InoMKnvFvDh+J5gFNHN1mmUONxvYJqFImLJY8/bl9YA=" # MY OWN
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" # AYUGRAM
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" # NYX
      #
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # HYPRLAND
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" # COSMIC
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" # NIRI
    ];
    over =
      with inputs;
      let
        xpackage = self.packages.${pkgs.system};
      in
      [
        niri.overlays.niri
        nur.overlays.default
        (f: p: xpackage)
        (f: p: {
          zen-browser = xpackage.zen-browser;
        })
        (f: p: {
          stable = import nixpkgs-stable {
            inherit (p)
              system
              config
              ;
          };
        })
        (f: p: {
          cursor = cursors.packages.${pkgs.system};
        })
      ];
  };
}
