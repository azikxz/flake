{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.ncmpcpp;
in

{
  options = {
    module.programs.cli.ncmpcpp = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.mpd = on // {
      package = pkgs.mpd-small;
    };
    programs.ncmpcpp = on // {
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
      };
      settings = import ./settings.nix;
    };
  };
}
