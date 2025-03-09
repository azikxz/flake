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
      "https://hyprland.cachix.org" # HYPRLAND
      "https://cache.garnix.io" # AYUGRAM
      "https://helix.cachix.org" # HELIX
      "https://xache.cachix.org" # MY OWN
      "https://niri.cachix.org" # NIRI
    ];
    keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" # NIX GAMING
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # HYPRLAND
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" # AYUGRAM
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" # HELIX
      "xache.cachix.org-1:InoMKnvFvDh+J5gFNHN1mmUONxvYJqFImLJY8/bl9YA=" # MY OWN
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" # NIRI
    ];
    over = with inputs; [
      niri.overlays.niri
      (final: prev: { xpk = self.packages.${pkgs.system}; })
    ];
  };
}
