{ x, ... }:
let
  inherit (x) on umport;
in
{
  imports = umport {
    path = ./.;
    exclude = [ ./default.nix ];
  };
  module = {
    base = on;
    themes.stylix = on;
    services = {
      amneziawg = on;
      zram.algo = "zstd";
    };
  };
}
