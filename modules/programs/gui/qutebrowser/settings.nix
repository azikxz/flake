{
  lib,
  config,
}:

with lib;

{
  inherit
    (import ./rules.nix {
      inherit
        lib
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
        format = "[{index}] {current_title}";
        format_pinned = "";
      };
    };

    colors = with config.lib.stylix.colors.withHashtag; {
      tabs = {
        odd.fg = mkForce base03;

        even = {
          bg = mkForce base00;
          fg = mkForce base03;
        };

        selected = {
          even.bg = mkForce base02;
          odd.bg = mkForce base02;
        };

        pinned = {
          even.bg = mkForce base00;
          odd.bg = mkForce base00;

          selected = {
            even.bg = mkForce base02;
            odd.bg = mkForce base02;
          };
        };
      };

      webpage = {
        preferred_color_scheme = "dark";
        darkmode.enabled = true;
      };

      hints = {
        bg = mkForce base04;
        fg = mkForce base00;
      };
    };

    fonts = with config.stylix.fonts; {
      default_family = mkForce monospace.name;
    };

    content = {
      blocking = {
        enabled = true;

        method = "both";

        whitelist = [
          "thepiratebay.org"
          "trueachievements.com"
        ];

        hosts.lists = [
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2020.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2021.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2022.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2023.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2024.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/filters-2025.txt"

          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/badware.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/privacy.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/quick-fixes.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/refs/heads/master/filters/unbreak.txt"

          # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/annoyances-cookies.txt"
          # "https://easylist.to/easylist/easylist.txt"
          # "https://easylist.to/easylist/easyprivacy.txt"
          # "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          # "https://easylist.to/easylist/fanboy-social.txt"

          # "https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-domains.txt"
          # "https://github.com/easylist/easylist/raw/refs/heads/master/easylist_cookie/easylist_cookie_general_block.txt"
          # "https://github.com/easylist/easylist/raw/refs/heads/master/easylist_cookie/easylist_cookie_general_hide.txt"

          # "https://easylist-downloads.adblockplus.org/advblock.txt"
        ];
      };

      pdfjs = true;

      javascript.clipboard = "access";
    };

    hints = {
      scatter = false;
      chars = "asdfghjkl";
    };

    editor.command = [
      "kitty"
      "--class"
      "termfloat"
      "-e"
      "hx"
      "{file}:{line}:{column0}"
    ];

    fileselect = {
      handler = "external";

      single_file.command = [
        "kitty"
        "--class"
        "float-kitty"
        "-e"
        "yazi"
        "--chooser-file"
        "{}"
      ];

      multiple_files.command = [
        "kitty"
        "--class"
        "termfloat"
        "-e"
        "yazi"
        "--chooser-file"
        "{}"
      ];

      folder.command = [
        "kitty"
        "--class"
        "termfloat"
        "-e"
        "yazi"
        "--chooser-file"
        "{}"
      ];
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
