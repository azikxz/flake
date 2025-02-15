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
      settings = {
        ncmpcpp_directory = "~/.ncmpcpp";
        mpd_crossfade_time = 5;
        visualizer_output_name = "Visualizer";
        visualizer_in_stereo = "yes";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_fps = 60;
        visualizer_type = "ellipse";
        visualizer_spectrum_smooth_look = "no";
        visualizer_look = "▮▮";
        visualizer_color = "red,magenta,blue,cyan,green";
        user_interface = "alternative";
      };
    };
  };
}
