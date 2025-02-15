{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.fzf;
in

{
  options = {
    module.programs.cli.fzf = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.fzf = on // {
      defaultOptions = [
        "--border=rounded"
        "--info=hidden"
        "--no-mouse"
        "--margin=1,49%,1,1"
        "--padding=0"
      ];
    };
  };
}
