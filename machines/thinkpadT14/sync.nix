{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (mkDevice "jetpure" "DW4SRMG-3CK3ZRU-4Q2WQC3-O5FUM77-6BKCEDD-BFMDFOL-PCWOHAX-DUTMHQS")
  ];
}
