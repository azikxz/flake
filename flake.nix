{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";

    impermanence.url = "github:nix-community/impermanence";
    hardware.url = "github:NixOS/nixos-hardware/master";
    parts.url = "github:hercules-ci/flake-parts";
    flatpak.url = "github:gmodena/nix-flatpak";
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
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # design
    base16 = {
      url = "sourcehut:~neverness/design/base16";
      flake = false;
    }; # base16
    wallpapers = {
      url = "sourcehut:~neverness/design/wallpapers";
      flake = false;
    }; # wallpapers
  };

  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ]; # system arch
      imports = [ ./machines ]; # machines
    };
}
