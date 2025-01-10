{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # UNSTABLE
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11"; # STABLE
    nur.url = "github:nix-community/NUR"; # NUR

    impermanence.url = "github:nix-community/impermanence"; # IMPERA
    hardware.url = "github:NixOS/nixos-hardware/master"; # HARDWARE
    parts.url = "github:hercules-ci/flake-parts"; # PARTS
    gaming.url = "github:fufexan/nix-gaming"; # GAMING
    transg.url = "github:PanAeon/transg-tui"; # TRANSG
    hyprland.url = "github:hyprwm/Hyprland"; # HYPRLAND
    stylix.url = "github:danth/stylix"; # STYLIX

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # HM
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # DECLARATIVE DISK PART
    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # ONLY FOR UMPORT
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # COOL BROWSER
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # SPOTIFY
    ytcli = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TUI YOUTUBE
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # FIREFOX
    cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # COLORIZE CUSRSOR

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
      imports = [ ./jetpure ]; # machines | packages
    };
}
