{
  self,
  inputs,
  pkgs,
  ...
}:

let
  inherit (inputs) nixpkgs home nixcord;
  backup = "backa";
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
        steamUnified = null;
      },
      styl ? {
        theme = "horizon-dark";
        image = "train";
      },
      sec ? (builtins.pathExists secrets) import secrets args,
    }:

    let
      specialArgs = { inherit self inputs; };
      lib = nixpkgs.lib.extend (
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
            // import ./options/addit.nix {
              inherit
                self
                inputs
                lib
                pkgs
                ;
            }
            // import ./options/options.nix {
              inherit
                lib
                ;
            };
        }
      );
      # dirs
      modulesDir = self + "/modules";
      machineDir = self + "/machines/" + sys.hostName;
      # make nixossystem/home manager
      mkSystem =
        name:
        let
          mod = modulesDir + "/" + name;
          modEx = builtins.pathExists mod;
          mac = machineDir + "/" + type;
          macEx = builtins.pathExists mac;
          type =
            if name == "nixos" then
              "host"
            else if name == "home" then
              "home"
            else
              null;
        in
        [ ] ++ (lib.optional modEx mod) ++ (lib.optional macEx mac);
    in

    lib.nixosSystem {
      inherit lib specialArgs;
      modules =
        mkSystem "nixos"
        ++ [ home.nixosModules.home-manager ]
        ++ [
          {
            services.getty.autologinUser = sys.userName;
            networking = {
              hostName = sys.hostName;
              useDHCP = lib.mkDefault true;
            };
            home-manager = {
              sharedModules = [
                nixcord.homeModules.nixcord
              ];
              backupFileExtension = backup;
              extraSpecialArgs = specialArgs // {
                config' = self.nixosConfigurations.${machineName}.config;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${sys.userName} = {
                imports = mkSystem "home";
                home = {
                  username = sys.userName;
                  stateVersion = sys.ver;
                  homeDirectory = "/home/" + sys.userName;
                };
              };
            };
          }
        ];
    };

in

builtins.mapAttrs mkMachine
