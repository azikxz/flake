{
  pkgs,
  config,
}:

let
  inherit (builtins) toJSON;
  cfg = config.module.programs.gui.telegram;
  client =
    if cfg.package == (pkgs._64gram) then
      "64Gram"
    else if cfg.package == (pkgs.ayugram-desktop) then
      "AyuGramDesktop"
    else
      "TelegramDesktop";
in

{
  "${client}/tdata/enhanced-settings-custom.json".text = toJSON {
    always_delete_for = 0;
    auto_unmute = false;
    bitrate = 0;
    blocked_user_spoiler_mode = false;
    disable_cloud_draft_sync = false;
    disable_global_search = false;
    disable_link_warning = true;
    disable_premium_animation = false;
    hd_video = false;
    hide_all_chats = true;
    hide_classic_fwd = true;
    hide_counter = false;
    hide_stories = false;
    net_dl_speed_boost = true;
    net_speed_boost = 0;
    radio_controller = "http//localhost2468";
    recent_display_limit = 0;
    repeater_reply_to_orig_msg = false;
    replace_edit_button = true;
    screenshot_mode = false;
    show_emoji_button_as_text = false;
    show_group_sender_avatar = false;
    show_messages_id = false;
    show_phone_number = false;
    show_repeater_option = false;
    show_scheduled_button = false;
    show_seconds = false;
    skip_to_next = true;
    stereo_mode = false;
    translate_to_tc = false;
  };
  "${client}/tdata/ayu_settings.json".text = toJSON {
    appIcon = "alt";
    channelBottomButton = 0;
    collapseSimilarChannels = true;
    deletedMark = "deleted";
    disableAds = true;
    disableCustomBackgrounds = true;
    disableNotificationsDelay = true;
    disableStories = false;
    editedMark = "edited";
    gifConfirmation = false;
    hideAllChatsFolder = true;
    hideFromBlocked = true;
    hideNotificationBadge = false;
    hideNotificationCounters = false;
    hideSimilarChannels = false;
    increaseWebviewHeight = true;
    increaseWebviewWidth = true;
    localPremium = true;
    markReadAfterAction = false;
    monoFont = "JetBrainsMono Nerd Font";
    recentStickersCount = 100;
    replaceBottomInfoWithIcons = true;
    saveDeletedMessages = false;
    saveForBots = false;
    saveMessagesHistory = true;
    sendOfflinePacketAfterOnline = false;
    sendOnlinePackets = true;
    sendReadMessages = true;
    sendReadStories = false;
    sendUploadProgress = true;
    sendWithoutSound = false;
    showAttachButtonInMessageField = true;
    showAttachPopup = true;
    showAutoDeleteButtonInMessageField = true;
    showCommandsButtonInMessageField = true;
    showEmojiButtonInMessageField = true;
    showEmojiPopup = true;
    showGhostToggleInDrawer = true;
    showGhostToggleInTray = true;
    showHideMessageInContextMenu = 0;
    showLReadToggleInDrawer = false;
    showMessageDetailsInContextMenu = 2;
    showMessageSeconds = false;
    showMessageShot = true;
    showMicrophoneButtonInMessageField = true;
    showPeerId = 2;
    showReactionsPanelInContextMenu = 1;
    showSReadToggleInDrawer = true;
    showStreamerToggleInDrawer = false;
    showStreamerToggleInTray = false;
    showUserMessagesInContextMenu = 2;
    showViewsPanelInContextMenu = 1;
    simpleQuotesAndReplies = true;
    spoofWebviewAsAndroid = false;
    stickerConfirmation = false;
    useScheduledMessages = false;
    voiceConfirmation = false;
    wideMultiplier = 1.0;
  };
  "${client}/tdata/shortcuts-custom.json".text = toJSON [
    {
      command = "previous_folder";
      keys = "alt+,";
    }
    {
      command = "next_folder";
      keys = "alt+.";
    }
    {
      command = "show_archive";
      keys = "alt+a";
    }
    {
      command = "folder4";
      keys = "alt+b";
    }
    {
      command = "folder2";
      keys = "alt+c";
    }
    {
      command = "self_chat";
      keys = "alt+d";
    }
    {
      command = "media_viewer_video_fullscreen";
      keys = "alt+f";
    }
    {
      command = "first_chat";
      keys = "alt+g";
    }
    {
      command = "next_chat";
      keys = "alt+j";
    }
    {
      command = "previous_chat";
      keys = "alt+k";
    }
    {
      command = "last_folder";
      keys = "alt+m";
    }
    {
      command = "folder5";
      keys = "alt+n";
    }
    {
      command = "close_telegram";
      keys = "alt+q";
    }
    {
      command = "read_chat";
      keys = "alt+r";
    }
    {
      command = "show_contacts";
      keys = "alt+s";
    }
    {
      command = "folder3";
      keys = "alt+v";
    }
    {
      command = "folder1";
      keys = "alt+x";
    }
    {
      command = "all_chats";
      keys = "alt+z";
    }
    {
      command = "message";
      keys = "alt+return";
    }
    {
      command = "media_previous";
      keys = "alt+shift+;";
    }
    {
      command = "media_next";
      keys = "alt+shift+.";
    }
    {
      command = "media_playpause";
      keys = "alt+shift+/";
    }
    {
      command = "account1";
      keys = "alt+shift+1";
    }
    {
      command = "account2";
      keys = "alt+shift+2";
    }
    {
      command = "account3";
      keys = "alt+shift+3";
    }
    {
      command = "account4";
      keys = "alt+shift+4";
    }
    {
      command = "account5";
      keys = "alt+shift+5";
    }
    {
      command = "account6";
      keys = "alt+shift+6";
    }
    {
      command = "archive_chat";
      keys = "alt+shift+a";
    }
    {
      command = "show_chat_menu";
      keys = "alt+shift+d";
    }
    {
      command = "last_chat";
      keys = "alt+shift+g";
    }
    {
      command = "quit_telegram";
      keys = "alt+shift+q";
    }
    {
      command = "show_scheduled";
      keys = "alt+shift+s";
    }
    {
      command = "message_silently";
      keys = "alt+shift+return";
    }
    {
      command = "message_scheduled";
      keys = "ctrl+alt+return";
    }
    {
      command = null;
      keys = "media previous";
    }
    {
      command = null;
      keys = "media next";
    }
    {
      command = null;
      keys = "toggle media play/pause";
    }
    {
      command = null;
      keys = "ctrl+0";
    }
    {
      command = null;
      keys = "ctrl+1";
    }
    {
      command = null;
      keys = "ctrl+2";
    }
    {
      command = null;
      keys = "ctrl+3";
    }
    {
      command = null;
      keys = "ctrl+4";
    }
    {
      command = null;
      keys = "ctrl+5";
    }
    {
      command = null;
      keys = "ctrl+6";
    }
    {
      command = null;
      keys = "ctrl+7";
    }
    {
      command = null;
      keys = "ctrl+8";
    }
    {
      command = null;
      keys = "ctrl+9";
    }
    {
      command = null;
      keys = "ctrl+f";
    }
    {
      command = null;
      keys = "ctrl+j";
    }
    {
      command = null;
      keys = "ctrl+l";
    }
    {
      command = null;
      keys = "ctrl+m";
    }
    {
      command = null;
      keys = "ctrl+q";
    }
    {
      command = null;
      keys = "ctrl+r";
    }
    {
      command = null;
      keys = "ctrl+w";
    }
    {
      command = null;
      keys = "ctrl+\\";
    }
    {
      command = null;
      keys = "ctrl+tab";
    }
    {
      command = null;
      keys = "ctrl+backtab";
    }
    {
      command = null;
      keys = "ctrl+pgup";
    }
    {
      command = null;
      keys = "ctrl+pgdown";
    }
    {
      command = null;
      keys = "ctrl+f4";
    }
    {
      command = null;
      keys = "ctrl+shift+tab";
    }
    {
      command = null;
      keys = "ctrl+shift+up";
    }
    {
      command = null;
      keys = "ctrl+shift+down";
    }
    {
      command = null;
      keys = "alt+up";
    }
    {
      command = null;
      keys = "alt+down";
    }
    {
      command = null;
      keys = "ctrl+alt+home";
    }
    {
      command = null;
      keys = "ctrl+alt+end";
    }
  ];
}
