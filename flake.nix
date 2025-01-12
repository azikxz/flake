{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";

    impermanence.url = "github:nix-community/impermanence";
    hardware.url = "github:NixOS/nixos-hardware/master";
    parts.url = "github:hercules-ci/flake-parts";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";

    gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # DESIGN
    base16 = {
      url = "sourcehut:~neverness/design/base16";
      flake = false;
    }; # BASE16
    wallpapers = {
      url = "sourcehut:~neverness/design/wallpapers";
      flake = false;
    }; # WALLPAPERS
  };

  outputs =
    inputs:
    with inputs;
    parts.lib.mkFlake { inherit inputs; } {
      perSystem.formatter =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.nixfmt-rfc-style;
      systems = [ "x86_64-linux" ]; # system arch
      imports = [ ./machines ]; # machines
    };
}
