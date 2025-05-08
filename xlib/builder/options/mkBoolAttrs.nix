{
  lib,
  ...
}:

with lib;
rec {
  on.enable = true;
  off.enable = false;

  mkOn = list: genAttrs list (n: on);
  mkOff = list: genAttrs list (n: off);
}
