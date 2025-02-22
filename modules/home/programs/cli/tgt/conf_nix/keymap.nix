# toml
''
  [core_window]
  keymap = [
    # quit
    { keys = ["q"],      command = "try_quit", description = "Quit the application"},
    { keys = ["esc"],    command = "unfocus_component", description = "Unfocus the current component"},
    { keys = ["alt+x"],  command = "toggle_chat_list", description = "Toggle chat_list visibility"},
    { keys = ["alt+1"],  command = "focus_chat_list", description = "Focus the chat list"},
    { keys = ["alt+2"],  command = "focus_chat", description = "Focus the chat"},
    { keys = ["alt+3"],  command = "focus_prompt", description = "Focus the prompt"},
    # size vhat list
    { keys = ["ctrl+l"], command = "increase_chat_list_size", description = "Increase the chat list size"},
    { keys = ["ctrl+h"], command = "decrease_chat_list_size", description = "Decrease the chat list size"},
    { keys = ["ctrl+k"], command = "increase_prompt_size", description = "Increase the prompt size"},
    { keys = ["ctrl+j"], command = "decrease_prompt_size", description = "Decrease the prompt size"},
    # additional
    # arrows
    { keys = ["alt+left"],  command = "focus_chat_list", description = "Focus the chat list"},
    { keys = ["alt+right"], command = "focus_chat", description = "Focus the chat"},
    { keys = ["alt+down"],  command = "focus_prompt", description = "Focus the prompt"},
    # vi keys
    { keys = ["alt+h"],  command = "focus_chat_list", description = "Focus the chat list"},
    { keys = ["alt+l"], command = "focus_chat", description = "Focus the chat"},
    { keys = ["alt+j"],  command = "focus_prompt", description = "Focus the prompt"},
  ]

  [chat_list]
  keymap = [
    # arrows
    { keys = ["down"],  command = "chat_list_next", description = "Select the next chat"},
    { keys = ["up"],    command = "chat_list_previous", description = "Select the previous chat"},
    { keys = ["left"],  command = "chat_list_unselect", description = "Unselect the current chat"},
    { keys = ["right"], command = "chat_list_open", description = "Open the selected chat"},
    # vi keys
    { keys = ["j"],     command = "chat_list_next", description = "Select the next chat"},
    { keys = ["k"],     command = "chat_list_previous", description = "Select the previous chat"},
    { keys = ["h"],     command = "chat_list_unselect", description = "Unselect the current chat"},
    { keys = ["l"],     command = "chat_list_open", description = "Open the selected chat"},
    # ok
    { keys = ["enter"], command = "chat_list_open", description = "Open the selected chat"},
  ]

  [chat]
  keymap = [
    # vi keys
    { keys = ["j"], command = "chat_window_next", description = "Select the next message"},
    { keys = ["k"], command = "chat_window_previous", description = "Select the previous message"},
    { keys = ["h"], command = "chat_window_unselect", description = "Unselect the current message"},
    { keys = ["l"], command = "chat_window_reply", description = "Reply to the selected message"},
    # delete
    { keys = ["d"], command = "chat_window_delete_for_everyone", description = "Delete the selected message for all users"},
    { keys = ["D"], command = "chat_window_delete_for_me", description = "Delete the selected message for 'me'"},
    # actions
    { keys = ["y"], command = "chat_window_copy", description = "Copy the selected message"},
    { keys = ["e"], command = "chat_window_edit", description = "Edit the selected message"},
    { keys = ["r"], command = "chat_window_reply", description = "Reply to the selected message"},
  ]
''
