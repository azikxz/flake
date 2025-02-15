{
  self,
  ...
}@inputs:

let
  inherit (inputs) nixpkgs;
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  build = import ./builder { inherit self inputs; };
in

{
  nixosConfigurations = build (import "${self}/machines");
  formatter =
    let
      mk = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
      ];
    in
    mk (system: pkgs.nixfmt-rfc-style);
}
