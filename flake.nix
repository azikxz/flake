{
  outputs = args: import ./xlib args;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-2511.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-2411.url = "github:NixOS/nixpkgs/nixos-24.11";

    hardware.url = "github:NixOS/nixos-hardware/master";
    utils.url = "github:numtide/flake-utils";
    flatpak.url = "github:gmodena/nix-flatpak";

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";

      # disable support
      inputs.darwin.follows = "";
      inputs.home-manager.follows = "";
    };

    sopsnix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
      inputs.nur.follows = "nur";
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

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-2511";
    };

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
    };

    plasma = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
      inputs.ndg.follows = "ndg";
    };

    # added for override nvf input
    ndg = {
      url = "github:feel-co/ndg";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anipy = {
      url = "github:sdaqo/anipy-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jerry = {
      url = "github:justchokingaround/jerry";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "parts";
    };

    viu = {
      url = "github:viu-media/viu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    curd = {
      url = "github:Wraient/curd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    glide = {
      url = "github:glide-browser/glide.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    addons2nix = {
      url = "github:azikxz/mozilla-addons-to-nix";
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

    hytale = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fjordlauncher = {
      url = "github:unmojang/FjordLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minecraft-assets = {
      url = "github:azikxz/assets";
      flake = false;
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
      url = "github:kotudemo/zapret-presets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapret-alt = {
      url = "github:kartavkun/zapret-discord-youtube";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    easyeffects = {
      url = "github:azikxz/easyeffects-presets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # selfmade style
    base16 = {
      url = "github:azikxz/design/base16";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:azikxz/design/wallpapers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # non flake tools
    protonfixes = {
      url = "github:Open-Wine-Components/umu-protonfixes";
      flake = false;
    };

    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

    dns-malw-link = {
      url = "github:azikxz/dns.malw.link/azikx_patches";
      flake = false;
    };
  };
}
