{
  inputs,
  path ? {
    pass = null;
    flakeDir = "/etc/nixos";
  },
  sys ? {
    hostName = "starship";
    userName = "amogus";
    is = null;
    platform = "x86_64-linux";
    ver = "24.05";
  },
  styl ? {
    theme = "horizon-dark";
    image = "train";
  },
  ...
}:
let
  # OTHER
  pkgs = nixpkgs.legacyPackages.${sys.platform};
  inherit (inputs) home-manager nixpkgs;
  inherit (nixpkgs) lib;
  # NEEDS
  args = { inherit x inputs; };
  x =
    import ./options.nix { inherit inputs pkgs lib; }
    // import ./mkOpt.nix { inherit lib; }
    // {
      inherit path sys styl;
    };

  mk =
    n:
    let
      mod = ../modules/${n};
      modEx = builtins.pathExists mod;
      mac = ../machines/${sys.hostName}/${type};
      macEx = builtins.pathExists mac;
      type =
        if n == "nixos" then
          "host"
        else if n == "home" then
          "home"
        else
          "";
    in
    [ ] ++ lib.optional modEx mod ++ lib.optional macEx mac;
in
# configurations
{
  formatter = pkgs.nixfmt-rfc-style;
  nixosConfigurations.${sys.hostName} = lib.nixosSystem {
    specialArgs = args;
    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          backupFileExtension = "backup";
          extraSpecialArgs = args;
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${sys.userName} = {
            imports = mk "home";
            home = {
              username = sys.userName;
              stateVersion = sys.ver;
              homeDirectory = "/home/${sys.userName}";
            };
          };
        };
      }
    ] ++ mk "nixos";
  };
}
