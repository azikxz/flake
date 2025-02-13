{ x, ... }:
let
  inherit (x) on umport;
in
{
  imports = umport {
    path = ./.;
    exclude = [ ./default.nix ];
  };
  module.themes.stylix = on;
}
