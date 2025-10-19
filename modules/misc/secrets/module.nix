{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.age.secrets;
in

{
  options = {
    secrets = mkOption {
      description = "Shortcut paths to age secrets";

      type = types.attrsOf types.str;
      default = { };
    };
  };

  config = {
    secrets = mapAttrs (name: _: cfg.${name}.path) cfg;
  };
}
