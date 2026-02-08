inputs@{
  self,
  ...
}:

let
  inherit (inputs)
    nixpkgs
    utils
    nur
    ;

  config = {
    allowBroken = true;
    allowInsecure = true;
    allowUnfree = true;
  };
in

utils.lib.eachSystem
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
          config
          ;

        overlays = [ nur.overlays.default ];
      };
    in
    {
      formatter = pkgs.nixfmt-rfc-style;

      packages = (
        lib.filesystem.packagesFromDirectoryRecursive {
          directory = ../packages;

          callPackage = lib.callPackageWith (
            {
              inherit
                self
                inputs
                pkgs
                lib
                ;

              # for firefox addons
              inherit (pkgs.nur.repos.rycee.firefox-addons)
                buildFirefoxXpiAddon
                ;

              obsidian = import ./obsidianBuilders {
                inherit
                  pkgs
                  lib
                  ;
              };
            }
            // self.packages.${system}
          );
        }
      );

      devShells = lib.listToAttrs (
        map (path: {
          name = (lib.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf path));
          value = import path {
            inherit
              pkgs
              lib
              ;
          };
        }) (lib.filesystem.listFilesRecursive ../shells)
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
          theme = null;
          image = null;
        },
        secrets ? (builtins.pathExists secrets) (import "${self}/secrets.nix" args),
      }:

      let
        pkgs = import nixpkgs {
          system = lib.system.platform;

          inherit
            config
            ;

          stdenv.hostPlatform = lib.mkDefault system.platform;

          overlays = with inputs; [
            fjordlauncher.overlays.default
            glide.overlays.default
            minecraft.overlays.default
            niri.overlays.niri
            nur.overlays.default

            (
              final: prev:
              let
                system = lib.system.platform;
              in
              {
                _2505 = import nixpkgs-2505 {
                  inherit
                    system
                    config
                    ;
                };

                _2511 = import nixpkgs-2511 {
                  inherit
                    system
                    config
                    ;
                };

                _2411 = import nixpkgs-2411 {
                  inherit
                    system
                    config
                    ;
                };

                agenix = agenix.packages.${system}.default;
                anipy-cli = anipy.packages.${system}.default;
                curd = jerry.packages.${system}.default;
                hytale = hytale.packages.${system}.default;
                jerry = jerry.packages.${system}.full;
                viu = viu.packages.${system}.default;

                cursors = cursors.packages.${system};
                gaming = gaming.packages.${system};
                spicetify = spicetify.legacyPackages.${system};
              }
              // self.packages.${system}
              // winapps.packages."${system}"
            )
          ];
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
              self
              inputs
              pkgs
              lib
              ;
          }
        );
      in

      lib.nixosSystem {
        inherit
          pkgs
          lib
          specialArgs
          ;

        modules =
          (
            (lib.umport {
              path = ../machines/${machine};
            })
            ++ (lib.mkUmport ../modules [ ])
            ++ (with inputs; [
              disko.nixosModules.default
              flatpak.nixosModules.nix-flatpak
              gaming.nixosModules.pipewireLowLatency
              gaming.nixosModules.platformOptimizations
              gaming.nixosModules.wine
              home.nixosModules.home-manager
              impermanence.nixosModules.impermanence
              mangowc.nixosModules.mango
              minecraft.nixosModules.minecraft-servers
              musnix.nixosModules.default
              nixpkgs.nixosModules.notDetected
              nur.modules.nixos.default
              sopsnix.nixosModules.default
              stylix.nixosModules.default
              zapret-alt.nixosModules.default
              zapret.nixosModules.presets
            ])
          )
          ++ [
            {
              home-manager = {
                sharedModules = with inputs; [
                  mangowc.hmModules.mango
                  jerry.homeManagerModules.default
                  niri.homeModules.niri
                  niri.homeModules.stylix
                  nixcord.homeModules.nixcord
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
                preferXdgDirectories = true;
              };
            }
            {
              imports = [
                # INFO: hm aliases
                (lib.mkAliasOptionModule
                  [ "hm" ]
                  [
                    "home-manager"
                    "users"
                    system.userName
                  ]
                )

                (lib.mkAliasOptionModule
                  [ "hmPackages" ]
                  [
                    "home-manager"
                    "users"
                    system.userName
                    "home"
                    "packages"
                  ]
                )

                (lib.mkAliasOptionModule
                  [ "hmMime" ]
                  [
                    "home-manager"
                    "users"
                    system.userName
                    "xdg"
                    "mimeApps"
                    "defaultApplications"
                  ]
                )

                # INFO: nixos aliases
                (lib.mkAliasOptionModule
                  [ "packages" ]
                  [
                    "environment"
                    "systemPackages"
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
