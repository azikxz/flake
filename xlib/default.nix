inputs@{
  self,
  ...
}:

let
  inherit (inputs)
    nixpkgs
    flake-utils
    ;
in

flake-utils.lib.eachSystem
  [
    "x86_64-linux"
    "aarch64-linux"
  ]
  (
    system:
    let
      inherit (nixpkgs)
        lib
        ;

      pkgs = import nixpkgs {
        inherit
          system
          ;
      };
    in
    {
      formatter = pkgs.nixfmt-rfc-style;

      packages = (
        lib.filesystem.packagesFromDirectoryRecursive {
          directory = ../packages;

          callPackage = lib.callPackageWith {
            inherit
              self
              inputs
              pkgs
              lib
              ;

            obsidian = import ./obsidianBuilders {
              inherit
                pkgs
                lib
                ;
            };
          };
        }
      );
    }
  )
// {
  nixosConfigurations =
    (builtins.mapAttrs (
      machine:
      args@{
        system ? {
          hostName = "starship";
          userName = "amogus";
          platform = "x86_64-linux";
          version = "24.05";
        },
        paths ? {
          flakeDir = "/etc/nixos";
          winePrefix = null;
          persist = null;
        },
        style ? {
          theme = "horizon-dark";
          image = "train";
        },
        secrets ? (builtins.pathExists secrets) (import "${self}/secrets.nix" args),
      }:

      let
        pkgs = import nixpkgs {
          system = system.platform;
        };

        specialArgs = {
          inherit
            self
            inputs
            ;
        };

        lib = inputs.nixpkgs.lib.extend (
          final: prev:
          {
            inherit (inputs.home.lib)
              hm
              ;

            inherit
              machine
              system
              paths
              style
              secrets
              ;
          }
          // import ./options {
            inherit
              inputs
              pkgs
              lib
              ;
          }
        );
      in

      lib.nixosSystem {
        inherit
          lib
          specialArgs
          ;

        modules =
          (
            let
              modulesDir = "${self}/modules";
              machineDir = "${self}/machines/${machine}";
            in
            [ ]
            ++ (lib.optional (lib.pathExists modulesDir) modulesDir)
            ++ (lib.optional (lib.pathExists machineDir) machineDir)
            ++ (with inputs; [
              disko.nixosModules.default
              flatpak.nixosModules.nix-flatpak
              gaming.nixosModules.pipewireLowLatency
              gaming.nixosModules.platformOptimizations
              gaming.nixosModules.wine
              home.nixosModules.home-manager
              impermanence.nixosModules.impermanence
              musnix.nixosModules.default
              nixpkgs.nixosModules.notDetected
              nur.modules.nixos.default
              stylix.nixosModules.stylix
              zapret.nixosModules.presets
            ])
          )
          ++ [
            {
              home-manager = {
                sharedModules = with inputs; [
                  niri.homeModules.niri
                  niri.homeModules.stylix
                  nixcord.homeModules.nixcord
                  nur.modules.homeManager.default
                  spicetify.homeManagerModules.default
                ];

                useGlobalPkgs = true;
                extraSpecialArgs = specialArgs;
              };
            }
            {
              hm.home = rec {
                username = system.userName;
                stateVersion = system.version;
                homeDirectory = "/home/${username}";
              };
            }
            {
              imports = [
                (lib.mkAliasOptionModule
                  [ "hm" ]
                  [
                    "home-manager"
                    "users"
                    system.userName
                  ]
                )

                (lib.mkAliasOptionModule
                  [ "tmp" ]
                  [
                    "systemd"
                    "tmpfiles"
                    "settings"
                  ]
                )
              ];
            }
          ];
      }
    ))
      (import "${self}/machines");
}
