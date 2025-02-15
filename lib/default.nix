{
  self,
  ...
}@inputs:

let
  build = import ./builder { inherit self inputs; };
in

{
  formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
  nixosConfigurations = build (import "${self}/machines");
}
