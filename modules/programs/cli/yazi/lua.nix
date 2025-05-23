{
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

# lua
''
  require("full-border"):setup { type = ui.Border.ROUNDED, }
  require("yatline"):setup({
    section_separator = { open = "", close = "" },
    part_separator    = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },

    style_a = {
      fg = "${base00}",
      bg_mode = {
        normal = "${base0C}",
        select = "${base0A}",
        un_set = "${base09}"
      }
    },
    style_b = {
      bg = "${base03}",
      fg = "${base05}"
    },
    style_c = {
      bg = "${base00}",
      fg = "${base05}"
    },

    permissions_t_fg = "green",
    permissions_r_fg = "yellow",
    permissions_w_fg = "red",
    permissions_x_fg = "cyan",
    permissions_s_fg = "darkgray",

    show_background     = false,
    display_header_line = true,
    display_status_line = true,
    tab_width           = 20,
    tab_use_inverse     = false,

    selected = { icon = "󰻭", fg = "yellow" },
    copied   = { icon = "", fg = "green" },
    cut      = { icon = "", fg = "red" },

    total     = { icon = "󰮍", fg = "yellow" },
    succ      = { icon = "", fg = "green" },
    fail      = { icon = "", fg = "red" },
    found     = { icon = "󰮕", fg = "blue" },
    processed = { icon = "󰐍", fg = "green" },

    header_line = {
      left = {
        section_a = { { type = "string", custom = false, name = "tab_path", params = {
                        trimed = true, max_length = 24, trim_length = 5 } }, },
        section_b = { },
        section_c = { }
      },
      right = {
        section_a = { { type = "line", custom = false, name = "tabs", params = {"right"} }, },
        section_b = { },
        section_c = { { type = "coloreds", custom = false, name = "githead" }, }
      }
    },

    status_line = {
      left = {
        section_a = { { type = "string",   custom = false, name = "tab_mode" }, },
        section_b = { { type = "string",   custom = false, name = "tab_num_files" }, },
        section_c = { { type = "coloreds", custom = false, name = "count", params = "true" },
                      { type = "string",   custom = false, name = "hovered_size" }, }
      },
      right = {
        section_a = { { type = "string",   custom = false, name = "date", params = { "%d/%m/%Y" } }, },
        section_b = { { type = "string",   custom = false, name = "hovered_file_extension", params = { true } },
                      { type = "string",   custom = false, name = "hovered_mime" }, },
        section_c = { { type = "coloreds", custom = false, name = "permissions" }, }
      }
    },
  })
''
