{
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

# toml
''
  [palette]
  background = "${base00}"
  background_two = "${base01}"
  background_three = "${base02}"

  primary_light = "${base06}"
  primary = "${base05}"
  primary_dark = "${base04}"

  secondary_light = "${base05}"
  secondary = "${base06}"
  secondary_dark = "${base04}"

  ternary_light = "${base05}"
  ternary = "${base06}"
  ternary_dark = "${base04}"

  highlight_one = "${base07}"
  highlight_two = "${base07}"

  [common]
  border_component_focused = { fg = "background_two", bg = "background", bold = false, underline = false, italic = false }
  item_selected = { fg = "", bg = "background_two", bold = true, underline = false, italic = false }
  timestamp = { fg = "primary_dark", bg = "background", bold = false, underline = false, italic = false }

  [chat_list]
  self = { fg = "primary", bg = "background", bold = false, underline = false, italic = false }
  item_selected = { fg = "", bg = "background_two", bold = false, underline = false, italic = false }
  item_chat_name = { fg = "primary_light", bg = "background", bold = true, underline = false, italic = false }
  item_message_content = { fg = "primary_dark", bg = "background", bold = false, underline = false, italic = true }
  item_unread_counter = { fg = "highlight_two", bg = "background", bold = true, underline = false, italic = false }

  [chat]
  self = { fg = "primary", bg = "background", bold = false, underline = false, italic = false }
  chat_name = { fg = "ternary", bg = "background", bold = true, underline = false, italic = false }
  message_myself_name = { fg = "secondary", bg = "background", bold = true, underline = false, italic = false }
  message_myself_content = { fg = "secondary_light", bg = "background", bold = false, underline = false, italic = false }
  message_other_name = { fg = "ternary", bg = "background", bold = true, underline = false, italic = false }
  message_other_content = { fg = "ternary_light", bg = "background", bold = false, underline = false, italic = false }
  message_reply_text = { fg = "primary", bg = "background", bold = false, underline = false, italic = false }
  message_myself_reply_name = { fg = "ternary_dark", bg = "background", bold = true, underline = false, italic = false }
  message_myself_reply_content = { fg = "primary_dark", bg = "background", bold = false, underline = false, italic = false }
  message_other_reply_name = { fg = "secondary_dark", bg = "background", bold = true, underline = false, italic = false }
  message_other_reply_content = { fg = "primary_dark", bg = "background", bold = false, underline = false, italic = false }

  [prompt]
  self = { fg = "primary", bg = "background", bold = false, underline = false, italic = false }
  message_text = { fg = "primary_light", bg = "background", bold = false, underline = false, italic = false }
  message_text_selected = { fg = "primary_light", bg = "background_three", bold = false, underline = false, italic = true }
  message_preview_text = { fg = "primary_dark", bg = "background", bold = false, underline = false, italic = false }

  [reply_message]
  self = { fg = "highlight_two", bg = "background", bold = false, underline = false, italic = false }
  message_text = { fg = "primary", bg = "background", bold = false, underline = false, italic = false }
''
