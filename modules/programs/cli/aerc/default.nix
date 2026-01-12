{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# tui email client

mkIf (mac "pcRyazenka") {
  hm.programs.aerc = {
    enable = true;

    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
        default-save-path = config.hm.xdg.userDirs.download;
        default-menu-cmd = getExe pkgs.fzf;
      };

      viewer = {
        show-headers = false;
        always-show-mime = true;
      };

      compose = {
        edit-headers = true;
        reply-to-self = false;

        # editor = getExe pkgs.vim;
      }
      // (
        let
          cfg = config.hm.programs.khard;
        in
        optionalAttrs cfg.enable {
          address-book-cmd = (getExe cfg.package) + " %s";
        }
      );

      ui = {
        styleset-name = "stylix";
        sidebar-width = 15;

        tab-title-account = " {{.Account}}";
        dirlist-left = " {{.Folder}} ";

        fuzzy-complete = true;
        mouse-enabled = false;
        msglist-scroll-offset = 5;
        show-thread-context = true;

        border-char-vertical = "│";
        border-char-horizontal = "─";
        spinner = "◜,◠,◝,◞,◡,◟";
        threading-enabled = true;
      };

      statusline = {
        column-left = "[ {{.Account}}]";
        column-center = "{{.PendingKeys}}";
        column-right = "{{.TrayInfo}} [ {{.StatusInfo}}]";
      };

      filters = {
        "text/plain" = "colorize";
        "text/calendar" = "calendar";
        "text/html" = "html | colorize";

        "application/pdf" = getExe pkgs.zathura + " -";

        "audio/*" = getExe pkgs.mpv + " -";
        "video/*" = getExe pkgs.mpv + " -";
        "image/*" = getExe pkgs.swayimg + " -";
      };
    };

    extraBinds = import ./binds.nix;

    stylesets.stylix = import ./theme.nix {
      inherit
        config
        ;
    };
  };
}
