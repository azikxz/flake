{
  x,
  ...
}:
with x;
{
  manager = {
    prepend_keymap = [
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
        on = [ "!" ];
        run = "shell '$SHELL' --block --confirm";
        desc = "Enter to shell";
      }

      {
        on = [ "<Esc>" ];
        run = "close";
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
        on = [ "C" ];
        run = "plugin ouch --args=zip";
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
        desc = "Rename";
      }
      {
        on = [
          "r"
          "n"
        ];
        run = "rename --empty=stem --cursor=start";
        desc = "Rename namefile";
      }
      {
        on = [
          "r"
          "e"
        ];
        run = "rename --empty=ext --cursor=end";
        desc = "Rename extension";
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
          "f"
          "f"
        ];
        run = "cd ${flakeDir}";
        desc = "Go to flake main dir";
      }
      {
        on = [
          "g"
          "f"
          "h"
        ];
        run = "cd ${flakeDir}/modules/home";
        desc = "Go to home modules";
      }
      {
        on = [
          "g"
          "f"
          "H"
        ];
        run = "cd ${flakeDir}/modules/host";
        desc = "Go to nixos modules";
      }
      {
        on = [
          "g"
          "n"
          "s"
        ];
        run = "cd /nix/store";
        desc = "Go to store";
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
        run = "yank";
        desc = "Yank files";
      }
      {
        on = [ "u" ];
        run = ''
          shell 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'
        '';
        desc = "Yank files systemly";
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
      {
        on = [
          "p"
          "f"
        ];
        run = "plugin paste-file";
        desc = "Create new file from clipboard";
      }
      {
        on = [
          "p"
          "F"
        ];
        run = "plugin paste-file --args='quiet'";
        desc = "Create new file from clipboard";
      }

      # mounts
      {
        on = [
          "m"
          "a"
        ];
        run = "plugin archivemount --args=mount";
        desc = "Mount selected archive";
      }
      {
        on = [
          "m"
          "u"
        ];
        run = "plugin archivemount --args=unmount";
        desc = "Unmount and save changes to original archive";
      }
    ];
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
