{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "HP32RHM-IQ6E35L-WBKIDIB-N5SXMMD-WPLNXRP-JQSWGZ4-YMRLJXW-Q6ZHUAZ")
  ];
}
