{
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
      enable = mkBool false;
      package = mkPkg pkgs.ayugram-desktop;
      walogram.mode = mkStr "solid"; # solid | background
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.dataFile =
      let
        client =
          if cfg.package == (pkgs._64gram) then
            "64Gram"
          else if cfg.package == (pkgs.ayugram-desktop) then
            "AyuGramDesktop"
          else
            (toString null);
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
        walogram = import ./walogram.nix {
          inherit
            pkgs
            config
            ;
        };
      in
      mkIf (cfg.package != null) {
        telegramTheme =
          hm.dag.entryAfter
            [
              ""
            ]
            # sh
            ''
              run ${getExe walogram}
            '';
      };
  };
}
