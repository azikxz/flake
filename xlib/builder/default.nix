{
  self,
  inputs,
  ...
}:

let
  backup = "backup";
  secretsFile = "${self}/secrets.nix";

  lists = with inputs; {
    nixos = [
      disko.nixosModules.default
      flatpak.nixosModules.nix-flatpak
      gaming.nixosModules.pipewireLowLatency
      home.nixosModules.home-manager
      impermanence.nixosModules.impermanence
      nixpkgs.nixosModules.notDetected
      nur.modules.nixos.default
      stylix.nixosModules.stylix
    ];

    home = [
      nixcord.homeModules.nixcord
      nur.modules.homeManager.default
      spicetify.homeManagerModules.default
    ];
  };

  makeMachines =
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
        passwords = null;
        flakeDir = "/etc/nixos";
        winePrefix = null;
        persist = null;
      },
      style ? {
        theme = "horizon-dark";
        image = "train";
      },
      secrets ? (builtins.pathExists secrets) import secretsFile args,
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

      mkSystem =
        with lib;
        let
          modulesDir = "${self}/modules";
          machineDir = "${self}/machines/${machineName}";

          modulesExist = pathExists modulesDir;
          machineExist = pathExists machineDir;
        in
        [ ] ++ (optional modulesExist modulesDir) ++ (optional machineExist machineDir) ++ lists.nixos;
    in

    lib.nixosSystem {
      inherit
        lib
        specialArgs
        ;

      modules = mkSystem ++ [
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

          home-manager = {
            sharedModules = lists.home;

            backupFileExtension = backup;

            extraSpecialArgs = specialArgs;

            useGlobalPkgs = true;
            useUserPackages = true;
          };

          hm.home = rec {
            username = system.userName;
            stateVersion = system.version;
            homeDirectory = "/home/${username}";
          };
        }
      ];
    };
in

builtins.mapAttrs makeMachines
