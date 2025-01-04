{ x, pkgs, ... }:
with x;
{
  nix = {
    package = pkgs.nix;
    settings = {
      warn-dirty = false;
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "${userName}"
        "@wheel"
      ];
      extra-substituters = [
        "https://nix-gaming.cachix.org" # NIX GAMING
        "https://hyprland.cachix.org" # HYPRLAND
        "https://cache.garnix.io" # AYUGRAM
      ];
      extra-trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" # NIX GAMING
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # HYPRLAND
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" # AYUGRAM
      ];
      builders-use-substitutes = true;
      auto-optimise-store = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
  news.display = "silent";
  manual = {
    manpages = False;
    json = False;
    html = False;
  };
}
