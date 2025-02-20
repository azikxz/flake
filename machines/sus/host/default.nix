{ lib, ... }:

let
  inherit (lib.x) on umport;
in

{
  imports = umport {
    path = ./.;
    exclude = [ ./default.nix ];
  };
  module = {
    themes.stylix = on;
    services.amneziawg = on;
  };
}
