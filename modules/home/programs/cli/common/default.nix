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
    module.programs.cli = mkGroup [
      "archivers"
      "bat"
      "eza"
      "fd"
      "fzf"
      "git"
      "ripgrep"
      "zoxide"
    ];
  };
}
