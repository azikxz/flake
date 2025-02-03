{
  inputs,
  lib,
  # lol
  pass ? "~/passwords.kdbx",
  # variables
  hostName ? "sus",
  userName ? "amogus",
  flakeDir ? "/etc/nixos",
  is ? null,
  # customize
  theme ? "horizon-dark",
  image ? "train",
  # sys info
  plfrm ? "x86_64-linux",
  ver ? "24.05",
  ...
}:
let
  # OTHER
  pkgs = inputs.nixpkgs.legacyPackages.${plfrm};
  inherit (inputs) home-manager nixpkgs;
  inherit (nixpkgs.lib) nixosSystem;
  # NEEDS
  args = { inherit x inputs; };
  x =
    import ./options.nix { inherit inputs pkgs lib; }
    // import ./mkOpt.nix { inherit lib; }
    // {
      inherit
        pass
        # variables
        hostName
        userName
        flakeDir
        is
        # customize
        theme
        image
        # sys info
        plfrm
        ver
        ;
    };

  mk =
    n:
    let
      type =
        if n == "nixos" then
          "host"
        else if n == "home" then
          "home"
        else
          "";
    in
    [
      ../modules/${n}
      ../machines/${hostName}/${type}
    ];
in
# configurations
{
  formatter = pkgs.nixfmt-rfc-style;
  nixosConfigurations.${hostName} = nixosSystem {
    specialArgs = args;
    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          backupFileExtension = "backup";
          extraSpecialArgs = args;
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${userName} = {
            imports = mk "home";
            home = {
              username = userName;
              stateVersion = ver;
              homeDirectory = "/home/${userName}";
            };
          };
        };
      }
    ] ++ mk "nixos";
  };
}
