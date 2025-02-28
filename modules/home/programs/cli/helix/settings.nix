{
  theme = "themo";
  editor = {
    line-number = "relative";
    mouse = true;
    cursorline = true;
    auto-completion = true;
    completion-replace = true;
    auto-info = true;
    auto-pairs = true;
    true-color = true;
    color-modes = true;
    bufferline = "multiple";
    indent-guides = {
      render = true;
      character = "»";
      skip-levels = 0;
    };
    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
    soft-wrap = {
      enable = true;
      max-wrap = 25;
      wrap-indicator = "┆ ";
    };
    statusline = {
      left = [
        "mode"
        "spacer"
        "spinner"
        "file-name"
        "file-modification-indicator"
        "read-only-indicator"
      ];
      center = [ ];
      right = [
        "register"
        "file-type"
        "separator"
        "spacer"
        "position"
        "position-percentage"
        "spacer"
        "separator"
        "total-line-numbers"
        "spacer"
      ];
      separator = "|";
      mode.normal = "NORMAL";
      mode.insert = "INSERT";
      mode.select = "SELECT";
    };
    file-picker = {
      hidden = false;
    };
  };
}
