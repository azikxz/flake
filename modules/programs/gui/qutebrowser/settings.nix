{
  lib,
  config,
}:

with lib;
let
  terminal =
    if config.hm.programs.kitty.enable then
      [
        "kitty"
        "--class"
        "termfloat"
        "-e"
      ]
    else if config.hm.programs.foot.enable then
      [
        "foot"
        "-a"
        "footfloat"
        "-e"
      ]
    else
      [ ];
in

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

    content = {
      register_protocol_handler = false;

      blocking = {
        enabled = true;

        method = "both";

        whitelist = [
          "thepiratebay.org"
          "trueachievements.com"
        ];

        adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          "https://easylist.to/easylist/fanboy-social.txt"
        ];
      };

      pdfjs = true;

      javascript.clipboard = "access";
    };

    hints = {
      scatter = false;
      chars = "asdfghjkl";
    };

    editor.command = terminal ++ [
      "hx"
      "{file}:{line}:{column0}"
    ];

    fileselect = {
      handler = "external";

      single_file.command = terminal ++ [
        "yazi"
        "--chooser-file"
        "{}"
      ];

      multiple_files.command = terminal ++ [
        "yazi"
        "--chooser-file"
        "{}"
      ];

      folder.command = terminal ++ [
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
