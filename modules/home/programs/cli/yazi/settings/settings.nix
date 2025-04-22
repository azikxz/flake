{
  lib,
  ...
}:

{
  shellWrapperName = "yy";
  settings = {
    manager = {
      ratio = [
        1
        4
        4
      ];
      show_hidden = false;
      sort_by = "natural";
      sort_dir_first = true;
      sort_reverse = false;
      linemode = "size";
      show_symlink = true;
    };
    preview = {
      wrap = "yes";
      tab_size = 1;
      image_filter = "lanczos3";
      image_quality = 90;
      max_height = 5000;
      max_width = 5000;
    };
    input = lib.genAttrs [
      "cd_origin"
      "find_origin"
      "create_origin"
      "delete_origin"
      "search_origin"
      "shell_origin"
    ] (n: "center");
    plugin = {
      prepend_previewers =
        (map
          (mime: {
            inherit mime;
            run = "ouch";
          })
          [
            "application/*zip"
            "application/*tar"
            "application/*bzip2"
            "application/*7z-compressed"
            "application/*rar"
            "application/*xz"
            "application/vnd.rar"
            "application/7z-compressed"
            "application/rar"
          ]
        )
        ++ [
          {
            name = "*.md";
            run = "glow";
          }
        ];
    };
    opener = import ./opener.nix;
    open = import ./open.nix;
  };
}
