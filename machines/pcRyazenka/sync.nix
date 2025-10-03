{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (mkDevice "blackmamba" "NUJDVWO-GBUQV64-ULXJUIK-4JQ7J6N-T6GZ7H4-2G7BNMN-WBIY646-U5HCCAA")
  ];
}
