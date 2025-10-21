{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.sops.secrets;
in

{
  options = {
    sopsnix = mkOption {
      description = "Shortcut paths to sopsnix secrets";

      type = types.attrsOf types.str;
      default = { };
    };
  };

  config = {
    sopsnix = mapAttrs (name: _: cfg.${name}.path) cfg;
  };
}
