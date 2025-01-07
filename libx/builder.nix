{
  inputs,
  lib,
  # variables
  disk ? null,
  hostName ? "sus",
  userName ? "amogus",
  flakeDir ? null,
  is ? null,
  # customize
  theme ? "horizon-dark",
  image ? "train",
  # sys info
  plfrm ? "x86_64-linux",
  ver ? "24.05",
  dev,
  ...
}:
let
  # OTHER
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.${plfrm};
  # NEEDS
  args = { inherit x inputs; };
  x = import ./options.nix { inherit inputs pkgs lib; } // {
    inherit
      # variables
      disk
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
      dev
      ;
  };
in
# configurations
{
  nixosConfigurations.${hostName} = nixosSystem {
    modules = [
      ../modules/nixos
      ../${hostName}/host
    ];
    specialArgs = args;
  };
  homeConfigurations.${userName} = homeManagerConfiguration {
    modules = [
      ../modules/home
      ../${hostName}/home
    ];
    extraSpecialArgs = args;
    inherit pkgs;
  };
}
