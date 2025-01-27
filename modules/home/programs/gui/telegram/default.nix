{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.telegram;
in
{
  options = {
    module.programs.gui.telegram = {
      client = mkOpt.str;
      walogram = {
        enable = mkBool;
        mode = mkOpt.str; # solid | background
      };
    };
  };

  config = {
    home.packages =
      let
        client =
          with pkgs;
          if cfg.client == "64gram" then
            _64gram
          else if cfg.client == "ayugram" then
            ayugram-desktop
          else
            null;
      in
      [ client ];
    xdg.dataFile =
      let
        client =
          if cfg.client == "64gram" then
            "64Gram"
          else if cfg.client == "ayugram" then
            "AyuGramDesktop"
          else
            toString null;
      in
      {
        "${client}/tdata/enhanced-settings-custom.json".text = # json
          ''
            {
                "always_delete_for": 0,
                "auto_unmute": false,
                "bitrate": 0,
                "blocked_user_spoiler_mode": false,
                "disable_cloud_draft_sync": false,
                "disable_global_search": false,
                "disable_link_warning": true,
                "disable_premium_animation": false,
                "hd_video": false,
                "hide_all_chats": true,
                "hide_classic_fwd": true,
                "hide_counter": false,
                "hide_stories": false,
                "net_dl_speed_boost": true,
                "net_speed_boost": 0,
                "radio_controller": "http://localhost:2468",
                "recent_display_limit": 0,
                "repeater_reply_to_orig_msg": false,
                "replace_edit_button": true,
                "screenshot_mode": false,
                "show_emoji_button_as_text": false,
                "show_group_sender_avatar": false,
                "show_messages_id": false,
                "show_phone_number": false,
                "show_repeater_option": false,
                "show_scheduled_button": false,
                "show_seconds": false,
                "skip_to_next": true,
                "stereo_mode": false,
                "translate_to_tc": false
            }
          '';
      };
    home.activation =
      let
        walogram = import ./walogram.nix { inherit pkgs config; };
      in
      mkIf cfg.walogram.enable {
        telegramTheme = hm.dag.entryAfter [ "" ] ''
          run ${getExe walogram}
        '';
      };
  };
}
