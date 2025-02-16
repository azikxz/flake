{
  description = ''
     _  _  _        ___   ___      __  _        _        
    | \| |(_)__ __ / _ \ / __|    / _|| | __ _ | |__ ___ 
    | .` || |\ \ /| (_) |\__ \   |  _|| |/ _` || / // -_)
    |_|\_||_|/_\_\ \___/ |___/   |_|  |_|\__,_||_\_\\___|
  '';

  outputs = args: import ./lib args;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    hardware.url = "github:NixOS/nixos-hardware/master";
    flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";

    gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
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
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xpk = {
      url = "path:./pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16 = {
      url = "sourcehut:~neverness/design/base16";
      flake = false;
    };
    wallpapers = {
      url = "sourcehut:~neverness/design/wallpapers";
      flake = false;
    };
  };
}
