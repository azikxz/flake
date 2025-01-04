{
  programs.helix.settings.keys = {
    normal = {
      y = "yank";
      Y = "yank_to_clipboard";
      D = "delete_selection_noyank";
      space = {
        space = "file_picker";
        c = "toggle_comments";
        f = "file_picker_in_current_directory";
        F = "file_picker";
        b = {
          b = "buffer_picker";
          n = ":buffer-next";
          p = ":buffer-previous";
          d = ":buffer-close";
          D = ":buffer-close!";
          O = ":buffer-close-others";
        };
      };
    };
    insert = { };
  };
}
