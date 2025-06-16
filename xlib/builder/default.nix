{
  self,
  inputs,
  ...
}:

builtins.mapAttrs (
  machineName:
  args@{
    system ? {
      itIs = null;
      disk = null;
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

        inherit (system)
          itIs
          ;

        inherit
          machineName
          system
          paths
          style
          secrets
          ;
      }
      // import ./options {
        inherit
          inputs
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
          machineDir = "${self}/machines/${machineName}";
        in
        [ ]
        ++ (lib.optional (lib.pathExists modulesDir) modulesDir)
        ++ (lib.optional (lib.pathExists machineDir) machineDir)
        ++ (with inputs; [
          disko.nixosModules.default
          flatpak.nixosModules.nix-flatpak
          gaming.nixosModules.pipewireLowLatency
          gaming.nixosModules.platformOptimizations
          home.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          libvirt.nixosModules.default
          nixpkgs.nixosModules.notDetected
          nur.modules.nixos.default
          stylix.nixosModules.stylix
        ])
      )
      ++ [
        {
          home-manager = {
            sharedModules = with inputs; [
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
          ];
        }
      ];
  }
)
