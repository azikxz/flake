{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "NGCBPYO-2DZI7E7-7DW6S4K-7YFSU6Z-XD4ZDGS-L6XVCY7-PBB75OX-WLF36AF")
    (mkDevice "jetpure" "MXTZHNN-YURXR4T-OOMPUYJ-I6CSHN7-RPIQPRG-JMOKQGF-SYM4G7D-5QGBZAF")
  ];
}
