{
  outputs = args: import ./xlib args;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-25.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-old.url = "github:nixos/nixpkgs/30a61f056ac492e3b7cdcb69c1e6abdcf00e39cf";

    impermanence.url = "github:nix-community/impermanence";
    hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    flatpak.url = "github:gmodena/nix-flatpak";

    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
      inputs.nur.follows = "nur";
    };

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
    };

    gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-24";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    anipy-cli = {
      url = "github:sdaqo/anipy-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
    };

    fjordlauncher = {
      url = "github:unmojang/FjordLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapret = {
      url = "github:mctrxw/nix-zapret-presets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # selfmade
    nixages = {
      url = "sourcehut:~neverness/nixages";
      inputs.flake-utils.follows = "flake-utils";
    };

    torrHelper = {
      url = "github:mctrxnv/torrserver-helper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    qbHelper = {
      url = "github:mctrxnv/qbHelper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    easyeffects = {
      url = "github:mctrxw/easyeffects-presets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # selfmade style
    base16 = {
      url = "sourcehut:~neverness/design/base16";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "sourcehut:~neverness/design/wallpapers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # umu-run tools
    protonfixes = {
      url = "github:Open-Wine-Components/umu-protonfixes";
      flake = false;
    };

    # other

    zsh-helix = {
      url = "github:Multirious/zsh-helix-mode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
