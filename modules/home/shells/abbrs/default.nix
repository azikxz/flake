{ x, lib, ... }:
with lib;
with x;
{
  options = {
    module.shells = {
      abbrs = mkOpt.attrs.str;
    };
  };
}
