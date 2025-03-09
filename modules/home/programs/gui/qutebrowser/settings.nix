{
  lib,
  config,
}:

let
  cfg = config.module.programs.gui.qutebrowser;
  f = lib.mkForce;
in

{
  quickmarks = cfg.quickmarks;
  settings = {
    url = {
      start_pages = [ "qute://start" ];
      default_page = "qute://start";
    };
    completion.height = "75%";
    downloads = {
      position = "bottom";
      location = {
        remember = true;
      };
    };
    confirm_quit = [ "downloads" ];
    scrolling = {
      bar = "overlay";
      smooth = true;
    };
    statusbar = {
      show = "in-mode";
      widgets = [
        "keypress"
        "search_match"
        "url"
        "tabs"
        "progress"
        "scroll"
      ];
    };
    tabs = {
      show = "multiple";
      position = "top";
      tooltips = false;
      show_switching_delay = 500;
      title = {
        format = "{index}: {current_title}";
        format_pinned = "{index}";
      };
    };
    colors = with config.lib.stylix.colors.withHashtag; {
      tabs = {
        even.bg = f base00;
        selected = {
          even.bg = f base03;
          odd.bg = f base03;
        };
      };
      webpage = {
        preferred_color_scheme = "dark";
        darkmode.enabled = true;
      };
      hints = {
        bg = f base04;
        fg = f base00;
      };
    };
    fonts = with config.stylix.fonts; {
      default_family = f "${monospace.name}";
    };
    content = {
      blocking.enabled = true;
      javascript.clipboard = "access";
    };
    hints = {
      scatter = false;
      chars = "asdfghjkl";
    };
  };
}
