{
  self,
}:

let
  inherit (self.nixosConfigurations.isoXtended.config.system)
    build
    ;
in

build.isoImage
