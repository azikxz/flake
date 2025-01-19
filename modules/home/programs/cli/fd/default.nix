{
  x,
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
  options.module.programs.cli.fd = {
    enable = mkBool;
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
