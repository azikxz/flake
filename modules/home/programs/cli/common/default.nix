{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.common;
in

{
  options = {
    module.programs.cli.common = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.cli = {
      archivers = on;
      bat = on;
      eza = on;
      fd = on;
      fzf = on;
      git = on;
      ripgrep = on;
      zoxide = on;
    };
  };
}
