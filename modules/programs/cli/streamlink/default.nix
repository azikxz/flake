{
  lib,
  ...
}:

with lib;
# INFO:
# stream in cli??? idk

mkIf false {
  hm.programs.streamlink = {
    enable = true;

    settings = {
      player = "mpv";
      player-args = "--cache 2048";
      player-no-close = true;
    };

    plugins = {
      twitch.settings = {
        player = "haruna";
        quiet = true;
      };

      steam.settings = {
        player = "haruna";
        quiet = true;
      };

      tiktok.settings = {
        player = "haruna";
        quiet = true;
      };

      googledrive.settings = {
        player = "haruna";
        quiet = true;
      };
    };
  };
}
