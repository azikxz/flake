{
  lib,
  ...
}:

with lib;

mkIf false {
  virtualisation.vmware =
    genAttrs
      [
        "guest"
        "host"
      ]
      (n: {
        enable = true;
      });
}
