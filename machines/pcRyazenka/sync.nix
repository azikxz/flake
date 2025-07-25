{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "NGCBPYO-2DZI7E7-7DW6S4K-7YFSU6Z-XD4ZDGS-L6XVCY7-PBB75OX-WLF36AF")
    (mkDevice "blackmamba" "NUJDVWO-GBUQV64-ULXJUIK-4JQ7J6N-T6GZ7H4-2G7BNMN-WBIY646-U5HCCAA")
  ];
}
