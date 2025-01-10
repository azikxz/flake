{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.qutebrowser;
  f = lib.mkForce;
in
{
  options = {
    module.programs.gui.qutebrowser = {
      enable = mkBool;
      quickmarks = mkOpt.attrs.str;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ python312Packages.adblock ];
    programs.qutebrowser = True // {
      quickmarks = cfg.quickmarks;
      settings = {
        url = {
          start_pages = [ "qute://start" ];
          default_page = "qute://start";
        };
        completion.height = "50%";
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
          show = "switching";
          position = "top";
          tooltips = false;
          show_switching_delay = 500;
          title = {
            format = "{index}: {current_title}";
            format_pinned = "{index}";
          };
        };
        window.hide_decoration = true;
        colors = with config.lib.stylix.colors.withHashtag; {
          webpage = {
            preferred_color_scheme = "dark";
            darkmode.enabled = true;
          };
          hints = {
            bg = f "${base04}";
            fg = f "${base00}";
          };
        };
        fonts = with config.stylix.fonts; {
          default_family = mkForce "${monospace.name}";
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
      searchEngines = {
        DEFAULT = "https://www.google.com/search?hl=en&q={}";
      };
    };
  };
}
