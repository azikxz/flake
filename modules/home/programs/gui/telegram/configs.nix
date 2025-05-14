{
  pkgs,
  lib,
  config,
}:

let
  cfg = config.module.programs.gui.telegram;
  client =
    if
      lib.elem cfg.package [
        pkgs._64gram
        pkgs.stable._64gram
      ]
    then
      "64Gram"
    else if cfg.package == (pkgs.ayugram-desktop) then
      "AyuGramDesktop"
    else
      "TelegramDesktop";
in

{
  "${client}/tdata/enhanced-settings-custom.json".text = builtins.toJSON {
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
  "${client}/tdata/ayu_settings.json".text = builtins.toJSON {
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
    monoFont = config.stylix.fonts.monospace.name;
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
  "${client}/tdata/shortcuts-custom.json".text =
    let
      mk = keys: command: { inherit command keys; };
      nk = mk null;
    in
    builtins.toJSON [
      (mk "alt+," "previous_folder")
      (mk "alt+." "next_folder")
      (mk "alt+a" "show_archive")
      (mk "alt+b" "folder4")
      (mk "alt+c" "folder2")
      (mk "alt+d" "self_chat")
      (mk "alt+f" "media_viewer_video_fullscreen")
      (mk "alt+g" "first_chat")
      (mk "alt+j" "next_chat")
      (mk "alt+k" "previous_chat")
      (mk "alt+m" "last_folder")
      (mk "alt+n" "folder5")
      (mk "alt+q" "close_telegram")
      (mk "alt+r" "read_chat")
      (mk "alt+s" "show_contacts")
      (mk "alt+v" "folder3")
      (mk "alt+x" "folder1")
      (mk "alt+z" "all_chats")
      (mk "alt+return" "message")
      (mk "alt+shift+" "media_previous")
      (mk "alt+shift+." "media_next")
      (mk "alt+shift+/" "media_playpause")
      (mk "alt+shift+1" "account1")
      (mk "alt+shift+2" "account2")
      (mk "alt+shift+3" "account3")
      (mk "alt+shift+4" "account4")
      (mk "alt+shift+5" "account5")
      (mk "alt+shift+6" "account6")
      (mk "alt+shift+a" "archive_chat")
      (mk "alt+shift+d" "show_chat_menu")
      (mk "alt+shift+g" "last_chat")
      (mk "alt+shift+q" "quit_telegram")
      (mk "alt+shift+s" "show_scheduled")
      (mk "alt+shift+return" "message_silently")
      (mk "ctrl+alt+return" "message_scheduled")
      (nk "media previous")
      (nk "media next")
      (nk "toggle media play/pause")
      (nk "ctrl+0")
      (nk "ctrl+1")
      (nk "ctrl+2")
      (nk "ctrl+3")
      (nk "ctrl+4")
      (nk "ctrl+5")
      (nk "ctrl+6")
      (nk "ctrl+7")
      (nk "ctrl+8")
      (nk "ctrl+9")
      (nk "ctrl+f")
      (nk "ctrl+j")
      (nk "ctrl+l")
      (nk "ctrl+m")
      (nk "ctrl+q")
      (nk "ctrl+r")
      (nk "ctrl+w")
      (nk "ctrl+\\")
      (nk "ctrl+tab")
      (nk "ctrl+backtab")
      (nk "ctrl+pgup")
      (nk "ctrl+pgdown")
      (nk "ctrl+f4")
      (nk "ctrl+shift+tab")
      (nk "ctrl+shift+up")
      (nk "ctrl+shift+down")
      (nk "alt+up")
      (nk "alt+down")
      (nk "ctrl+alt+home")
      (nk "ctrl+alt+end")
    ];
}
