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
    opener = {
      open = [ { run = "xdg-open $@"; } ];
      edit = [
        {
          run = ''hx "$@"'';
          block = true;
        }
      ];
      reveal = [ { run = ''xdg-open "$(dirname "$@")"''; } ];
      play = [
        {
          run = ''mpv --force-window "$@"'';
          orphan = true;
        }
      ];
      image = [
        {
          run = ''swayimg "$@"'';
          block = true;
        }
      ];
      document = [
        {
          desc = "Document";
          orphan = true;
          run = "libreoffice";
        }
      ];
      extract = [ { run = ''ouch d -y "$@"''; } ];
      kdbx = [
        {
          run = ''keepassxc $@'';
          orphan = true;
        }
      ];
      exe = [
        {
          run = ''wine $@'';
          orphan = true;
        }
      ];
    };
    open = {
      prepend_rules = [
        # kdbx
        {
          name = "*.kdbx";
          use = [
            "kdbx"
            "reveal"
          ];
        }
        {
          name = "*.exe";
          use = [
            "exe"
            "reveal"
          ];
        }
      ];
      rules = [
        # Folder
        {
          name = "*/";
          use = [
            "edit"
            "open"
            "reveal"
          ];
        }
        # Text
        {
          mime = "text/*";
          use = [
            "edit"
            "reveal"
          ];
        }
        # Image
        {
          mime = "image/*";
          use = [
            "open"
            "reveal"
          ];
        }
        # Media
        {
          mime = "{audio,video}/*";
          use = [
            "play"
            "reveal"
          ];
        }
        # Archive
        {
          mime = "application/{,g}zip";
          use = [
            "extract"
            "reveal"
          ];
        }
        {
          mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
          use = [
            "extract"
            "reveal"
          ];
        }
        # JSON
        {
          mime = "application/{json,x-ndjson,octet-stream}";
          use = [
            "edit"
            "reveal"
          ];
        }
        {
          mime = "*/javascript";
          use = [
            "edit"
            "reveal"
          ];
        }
        # Empty file
        {
          mime = "inode/x-empty";
          use = [
            "edit"
            "reveal"
          ];
        }
        {
          mime = "inode/empty";
          use = [
            "edit"
            "reveal"
          ];
        }
        # Fallback
        {
          name = "*";
          use = [
            "open"
            "reveal"
          ];
        }
        # Documents
        {
          mime = "application/vnd.openxmlformats-officedocument.*";
          use = "document";
        }
      ];
    };
    plugin = {
      prepend_previewers = [
        {
          mime = "application/*zip";
          run = "ouch";
        }
        {
          mime = "application/x-tar";
          run = "ouch";
        }
        {
          mime = "application/x-bzip2";
          run = "ouch";
        }
        {
          mime = "application/x-7z-compressed";
          run = "ouch";
        }
        {
          mime = "application/x-rar";
          run = "ouch";
        }
        {
          mime = "application/x-xz";
          run = "ouch";
        }
        {
          name = "*.md";
          run = "mdcat";
        }
      ];
    };
  };
}
