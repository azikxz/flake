{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.yazi;
in

{
  options = {
    module.programs.cli.yazi = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.yazi =
      on
      // {
        keymap = import ./binds.nix { inherit lib; };
        initLua = import ./lua.nix { inherit config; };
        theme = import ./theme.nix { inherit lib config; };
      }
      // import ./plugins.nix { inherit pkgs; }
      // import ./settings.nix;
    home.packages = with pkgs; [
      ffmpegthumbnailer
      wl-clipboard

      jq
      mdcat
      poppler_min

      atool
      ouch
    ];
  };
}
