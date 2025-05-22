{
  lib,
  config,
}:

{
  inherit
    (import ./rules.nix {
      inherit
        config
        ;
    })
    quickmarks
    whitelist
    userstyle
    ;

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
        odd.fg = lib.mkForce base03;

        even = {
          bg = lib.mkForce base00;
          fg = lib.mkForce base03;
        };

        selected = {
          even.bg = lib.mkForce base02;
          odd.bg = lib.mkForce base02;
        };
      };

      webpage = {
        preferred_color_scheme = "dark";
        darkmode.enabled = true;
      };

      hints = {
        bg = lib.mkForce base04;
        fg = lib.mkForce base00;
      };
    };

    fonts = with config.stylix.fonts; {
      default_family = lib.mkForce monospace.name;
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

  extraConfig = ''
    config.unbind('.')
    en_keys = "qwertyuiop[]asdfghjkl;'zxcvbnm,./"+'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
    ru_keys = 'йцукенгшщзхъфывапролджэячсмитьбю.'+'ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДжЭЯЧСМИТЬБЮ,'
    for key in ru_keys:
        c.bindings.key_mappings[key]=en_keys[ru_keys.index(key)]
  '';
}
