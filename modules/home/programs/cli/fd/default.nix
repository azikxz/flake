{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.fd;
in

{
  options = {
    module.programs.cli.fd = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.fd = on // {
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
  };
}
