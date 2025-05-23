{
  lib,
  config,
  ...
}:

with lib;

{
  manager = {
    prepend_keymap =
      [
        # main
        {
          on = [ "q" ];
          run = "close";
          desc = "Close tab/yazi";
        }
        {
          on = [ "l" ];
          run = "plugin smart-enter";
          desc = "Enter/open";
        }
        {
          on = [ "F" ];
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = [ "!" ];
          run = "shell '$SHELL' --block --confirm";
          desc = "Enter to shell";
        }

        # navigate
        {
          on = [ "<Esc>" ];
          run = "escape --all";
          desc = "Close";
        }
        {
          on = [ "<Right>" ];
          run = "plugin smart-enter";
          desc = "Enter/open";
        }
        {
          on = [ "<Enter>" ];
          run = "plugin smart-enter";
          desc = "Enter/open";
        }
        {
          on = [ "<A-Up>" ];
          run = "plugin parent-arrow -1";
          desc = "Navigation in the parent directory up";
        }
        {
          on = [ "<A-Down>" ];
          run = "plugin parent-arrow 1";
          desc = "Navigation in the parent directory down";
        }
        {
          on = [ "<A-k>" ];
          run = "plugin parent-arrow -1";
          desc = "Navigation in the parent directory up";
        }
        {
          on = [ "<A-j>" ];
          run = "plugin parent-arrow 1";
          desc = "Navigation in the parent directory down";
        }

        # bookmarks
        {
          on = [
            "b"
            "f"
          ];
          run = "cd ${paths.flakeDir}";
          desc = "Go to flake main dir";
        }
        {
          on = [
            "b"
            "d"
          ];
          run = "cd $XDG_DOWNLOAD_DIR";
          desc = "Go to xdg-downloads";
        }
        {
          on = [
            "b"
            "v"
          ];
          run = "cd $XDG_VIDEOS_DIR";
          desc = "Go to xdg-videos";
        }
        {
          on = [
            "b"
            "o"
          ];
          run = "cd $XDG_DOCUMENTS_DIR";
          desc = "Go to xdg-docs";
        }
        {
          on = [
            "b"
            "p"
          ];
          run = "cd $XDG_PICTURES_DIR";
          desc = "Go to xdg-pictures";
        }
        {
          on = [
            "b"
            "m"
          ];
          run = "cd $XDG_MUSIC_DIR";
          desc = "Go to xdg-music";
        }
        {
          on = [
            "b"
            "D"
          ];
          run = "cd $XDG_DESKTOP_DIR";
          desc = "Go to xdg-desktop";
        }

        # vis
        {
          on = [
            "v"
            "m"
          ];
          run = "plugin max-preview";
          desc = "Maximize preview";
        }
        {
          on = [
            "v"
            "p"
          ];
          run = "plugin hide-preview";
          desc = "Hide preview";
        }
        {
          on = [
            "v"
            "v"
          ];
          run = "visual_mode";
          desc = "Select mode";
        }
        {
          on = [
            "V"
          ];
          run = "escape --visual";
          desc = "Select mode";
        }
        {
          on = [
            "v"
            "V"
          ];
          run = "visual_mode --unset";
          desc = "Un-select mode";
        }
        {
          on = [
            "v"
            "a"
          ];
          run = "toggle_all --state=true";
          desc = "Select all";
        }
        {
          on = [
            "v"
            "r"
          ];
          run = "toggle_all --state=none";
          desc = "Unselect all";
        }
        {
          on = [
            "v"
            "h"
          ];
          run = "hidden toggle";
          desc = "Hidden files with .*";
        }

        # archive
        {
          on = [
            "C"
            "c"
          ];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = [
            "C"
            "C"
          ];
          run = "plugin ouch 7z";
          desc = "Compress with ouch";
        }

        # del
        {
          on = [
            "d"
            "d"
          ];
          run = "remove";
          desc = "Delete";
        }
        {
          on = [
            "d"
            "D"
          ];
          run = "remove --permanently";
          desc = "Delete permanently";
        }
        {
          on = [
            "D"
            "d"
          ];
          run = "remove --force";
          desc = "Delete force";
        }
        {
          on = [
            "D"
            "D"
          ];
          run = "remove --permanently --force";
          desc = "Delete permanently via force";
        }

        # create
        {
          on = [
            "a"
            "f"
          ];
          run = "create";
          desc = "Create file";
        }
        {
          on = [
            "a"
            "d"
          ];
          run = "create --dir";
          desc = "Create directory";
        }

        # rename
        {
          on = [
            "r"
            "r"
          ];
          run = "rename --cursor=end";
          desc = "Rename at end";
        }
        {
          on = [
            "r"
            "R"
          ];
          run = "rename --cursor=start";
          desc = "Rename at start";
        }
        {
          on = [
            "R"
          ];
          run = "rename --cursor=before_ext";
          desc = "Rename before ext";
        }
        {
          on = [
            "r"
            "f"
          ];
          run = "rename --empty=stem --cursor=start";
          desc = "Rename name of file";
        }
        {
          on = [
            "r"
            "F"
          ];
          run = "rename --empty=ext --cursor=end";
          desc = "Rename extension of file";
        }
        {
          on = [
            "r"
            "a"
          ];
          run = "rename --empty=all";
          desc = "Delete all and rename";
        }

        # naviagte
        {
          on = [
            "c"
            "d"
          ];
          run = "cd --interactive";
          desc = "Jump interactively";
        }
        {
          on = [
            "g"
            "r"
          ];
          run = ''
            shell 'ya emit cd "$(git rev-parse --show-toplevel)"'
          '';
          desc = "Go to root of git repo";
        }
        {
          on = [
            "g"
            "e"
          ];
          run = "arrow bot";
          desc = "Go to root of git repo";
        }

        # tabs
        {
          on = [ "t" ];
          run = "plugin smart-tab";
          desc = "Create a tab and enter the hovered directory";
        }
        {
          on = [ "]" ];
          run = "tab_switch -1 --relative";
          desc = "Switch to the next tab";
        }
        {
          on = [ "[" ];
          run = "tab_switch 1 --relative";
          desc = "Switch to the previous tab";
        }

        # yank
        {
          on = [ "y" ];
          run = [
            "plugin wl-clipboard"
            "yank"
          ];
          desc = "Yank files";
        }

        # paste
        {
          on = [
            "p"
            "p"
          ];
          run = "paste";
          desc = "Paste yanked files";
        }
        {
          on = [
            "p"
            "P"
          ];
          run = "plugin smart-paste";
          desc = "Paste yanked files in preview dir";
        }

        # chmod
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ]
      ++ (map (
        mount:
        let
          parts = split "/" mount;
          dirName = elemAt parts ((length parts) - 1);
          firstChar = (substring 0 1 dirName);
        in
        {
          on = [
            "b"
            "B"
            firstChar
          ];
          run = "cd " + toString mount;
          desc = "Go to " + toString mount;
        }
      ) (filter (p: hasPrefix "/media" p) (attrNames config.fileSystems)));
  };
  completion = {
    prepend_keymap = [
      {
        on = [ "<C-j>" ];
        run = "arrow 1";
      }
      {
        on = [ "<C-k>" ];
        run = "arrow -1";
      }
    ];
  };
}
