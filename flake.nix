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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-24";
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

    # zapret
    zapret = {
      url = "github:kotudemo/zapret-presets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.secret_files.follows = "secret_files";
      inputs.zapret-hostlists.follows = "zapret-hostlists";
    };

    secret_files = {
      url = "github:kotudemo/secret_files";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapret-hostlists = {
      url = "github:kotudemo/zapret-hostlists";
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

    umu-database = {
      url = "https://raw.githubusercontent.com/Open-Wine-Components/umu-database/refs/heads/main/umu-database.csv";
      flake = false;
    };
  };
}
