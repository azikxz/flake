{
  self,
  inputs,
  ...
}:

let
  inherit (inputs) home nixcord;
  secrets = ../../secrets.nix;
  # make configuration
  mkMachine =
    machineName:
    args@{
      sys ? {
        hostName = "starship";
        userName = "amogus";
        is = null;
        platform = "x86_64-linux";
        ver = "24.05";
      },
      path ? {
        pass = null;
        flake = "/etc/nixos";
      },
      styl ? {
        theme = "horizon-dark";
        image = "train";
      },
      sec ? (builtins.pathExists secrets) import secrets args,
    }:

    let
      spArgs = { inherit self inputs; };
      lib = inputs.nixpkgs.lib.extend (
        final: prev: {
          x =
            {
              xpk = self.packages.${sys.platform};
              inherit
                machineName
                path
                styl
                sys
                sec
                ;
            }
            // import ./options/addit.nix { inherit inputs lib; }
            // import ./options/mkOpt.nix { inherit lib; };
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
