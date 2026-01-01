{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# stream in cli??? idk

mkIf false {
  hm.programs.streamlink = {
    # WARN::
    # mkIf (config.hm.programs.mpv.enable) { ... }
    # replacement
    inherit (config.hm.programs.mpv)
      enable
      ;

    settings = {
      player = "mpv";
      player-args = "--cache 2048";
      player-no-close = true;
    };

    plugins =
      genAttrs
        [
          "twitch"
          "steam"
          "tiktok"
          "googledrive"
        ]
        (n: {
          settings = {
            player = "mpv";
            quiet = true;
          };
        });
  };
}
