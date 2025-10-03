{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (mkDevice "jetpure" "MXTZHNN-YURXR4T-OOMPUYJ-I6CSHN7-RPIQPRG-JMOKQGF-SYM4G7D-5QGBZAF")
  ];
}
