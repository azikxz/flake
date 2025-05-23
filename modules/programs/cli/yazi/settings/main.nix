{
  lib,
  config,
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

    input =
      let
        _ = n: n + "_origin";
      in
      lib.genAttrs [
        (_ "cd")
        (_ "find")
        (_ "rename")
        (_ "filter")
        (_ "create")
        (_ "delete")
        (_ "search")
        (_ "shell")
      ] (n: "center");

    plugin =
      let
        mk =
          run: list:
          (map (mime: {
            inherit
              mime
              ;
            run = "ouch";
          }) list);
      in
      {
        prepend_preloaders = mk "office" [
          "application/openxmlformats-officedocument.*"
          "application/oasis.opendocument.*"
          "application/msword"
          "application/ms-*"
          "*.docx"
        ];

        prepend_previewers =
          (mk "ouch" [
            "application/*zip"
            "application/*tar"
            "application/*bzip2"
            "application/*7z-compressed"
            "application/*rar"
            "application/*xz"
            "application/vnd.rar"
            "application/7z-compressed"
            "application/rar"
          ])
          ++ [
            {
              name = "*.md";
              run = "glow";
            }
          ];
      };

    opener = import ./opener.nix {
      inherit
        lib
        config
        ;
    };

    open = import ./open.nix;
  };
}
