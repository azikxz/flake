{
  pkgs,
  lib,
  ...
}:

pkgs.linkFarmFromDrvs "mods" (lib.attrValues { })
