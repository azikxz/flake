{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "HP32RHM-IQ6E35L-WBKIDIB-N5SXMMD-WPLNXRP-JQSWGZ4-YMRLJXW-Q6ZHUAZ")
    (mkDevice "jetpure" "MXTZHNN-YURXR4T-OOMPUYJ-I6CSHN7-RPIQPRG-JMOKQGF-SYM4G7D-5QGBZAF")
  ];
}
