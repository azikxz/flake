{
  self,
  inputs,
  ...
}:

let
  inherit (inputs) nixpkgs home nixcord;
  # make configuration
  mkMachine =
    dirName:
    {
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
    }:

    let
      pkgs = nixpkgs.legacyPackages.${sys.platform};
      spArgs = { inherit inputs; };
      lib = inputs.nixpkgs.lib.extend (
        final: prev: {
          x =
            {
              inherit path styl sys;
            }
            // import ./options.nix { inherit self pkgs lib; }
            // import ./mkOpt.nix { inherit lib; };
        }
      );
      # dirs
      modulesDir = "${self}/modules";
      machineDir = "${self}/machines/${sys.hostName}";
      # make nixossystem/home manager
      mkSystem =
        n:
        let
          mod = "${modulesDir}/${n}";
          modEx = builtins.pathExists mod;
          mac = "${machineDir}/${type}";
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

    lib.nixosSystem {
      inherit lib;
      specialArgs = spArgs;
      modules = [
        home.nixosModules.home-manager
        {
          home-manager = {
            sharedModules = [ nixcord.homeManagerModules.nixcord ];
            backupFileExtension = "backupr";
            extraSpecialArgs = spArgs;
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${sys.userName} = {
              imports = mkSystem "home";
              home = {
                username = sys.userName;
                stateVersion = sys.ver;
                homeDirectory = "/home/${sys.userName}";
              };
            };
          };
        }
      ] ++ mkSystem "nixos";
    };

in

builtins.mapAttrs mkMachine
