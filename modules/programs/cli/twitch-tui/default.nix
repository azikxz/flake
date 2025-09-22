{
  lib,
  config,
  ...
}:

with lib;
# INFO: twitch chat in tui, not viewer
# WARN: server doesnt works idk (russia)

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.twitch-tui = {
    enable = true;

    settings = {
      terminal = {
        delay = 30;
        first_state = "dashboard";
        maximum_messages = 1024 * 4;
      };

      twitch = rec {
        username = "x_azikx";
        channel = username;
        server = "irc.chat.twitch.tv";
        token = (n: replaceStrings [ "\n" ] [ "" ] n) (readFile ./token);
      };

      storage = genAttrs [ "channels" "mentions" ] (n: true);

      frontend = {
        show_datetimes = true;
        datetime_format = "%d/%m %H:%M";
        username_shown = true;
        palette = "pastel";
        title_shown = false;
        margin = 5;
        badges = true;
        theme = config.stylix.polarity;
        username_highlight = true;
        state_tabs = false;
        cursor_shape = "line";
        blinking_cursor = true;
        inverted_scrolling = false;
        show_scroll_offset = true;
        twitch_emotes = true;
        betterttv_emotes = true;
        seventv_emotes = true;
        frankerfacez_emotes = true;
        recent_channel_count = 5;
        border_type = "rounded";
        hide_chat_border = false;
        right_align_usernames = false;
        show_unsupported_screen_size = true;
        only_get_live_followed_channels = false;

        favorite_channels = [ ];
      };
    };
  };
}
