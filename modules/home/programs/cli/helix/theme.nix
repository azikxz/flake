{
  lib,
  config,
  ...
}:
with config.lib.stylix.colors.withHashtag;
lib.mkForce {
  themo =
    let
      BASE00 = "${base00}";
      BASE01 = "${base01}";
      BASE02 = "${base02}";
      BASE03 = "${base03}";
      BASE04 = "${base04}";
      BASE05 = "${base05}";
      BASE06 = "${base06}";
      BASE07 = "${base07}";
      BASE08 = "${base08}";
      BASE09 = "${base09}";
      BASE0A = "${base0A}";
      BASE0B = "${base0B}";
      BASE0C = "${base0C}";
      BASE0D = "${base0D}";
      BASE0E = "${base0E}";
      BASE0F = "${base0F}";
    in
    {
      "attributes" = BASE09;
      "comment" = {
        fg = BASE02;
        modifiers = [ "italic" ];
      };
      "constant" = BASE09;
      "constant.character.escape" = BASE0C;
      "constant.numeric" = BASE09;
      "constructor" = BASE0D;
      "debug" = BASE03;
      "diagnostic" = {
        modifiers = [ "underlined" ];
      };
      "diff.delta" = BASE09;
      "diff.minus" = BASE08;
      "diff.plus" = BASE0B;
      "error" = BASE08;
      "function" = BASE0D;
      "hint" = BASE03;
      "info" = BASE0D;
      "keyword" = BASE0E;
      "label" = BASE0E;
      "namespace" = BASE0E;
      "operator" = BASE05;
      "special" = BASE0D;
      "string" = BASE0B;
      "type" = BASE0A;
      "variable" = BASE08;
      "variable.other.member" = BASE0B;
      "warning" = BASE09;

      "markup.bold" = {
        fg = BASE0A;
        modifiers = [ "bold" ];
      };
      "markup.heading" = BASE0D;
      "markup.italic" = {
        fg = BASE0E;
        modifiers = [ "italic" ];
      };
      "markup.link.text" = BASE08;
      "markup.link.url" = {
        fg = BASE09;
        modifiers = [
          "underlined"
          "italic"
        ];
      };
      "markup.list" = BASE08;
      "markup.quote" = BASE0C;
      "markup.raw" = BASE0B;
      "markup.strikethrough" = {
        modifiers = [ "crossed_out" ];
      };

      "diagnostic.hint" = {
        underline = {
          style = "curl";
        };
      };
      "diagnostic.info" = {
        underline = {
          style = "curl";
        };
      };
      "diagnostic.warning" = {
        underline = {
          style = "curl";
        };
      };
      "diagnostic.error" = {
        underline = {
          style = "curl";
        };
      };

      "ui.background" = {
        fg = BASE04;
        bg = BASE00;
      };

      "ui.bufferline.separator" = {
        fg = BASE00;
        bg = BASE01;
      };
      "ui.bufferline.active" = {
        fg = BASE04;
        bg = BASE02;
        modifiers = [ "bold" ];
      };
      "ui.bufferline" = {
        fg = BASE04;
        bg = BASE00;
      };

      "ui.cursor" = {
        fg = BASE0A;
        modifiers = [ "reversed" ];
      };
      "ui.cursor.insert" = {
        fg = BASE0A;
        modifiers = [ "reversed" ];
      };
      "ui.cursorline.primary" = {
        fg = BASE05;
        bg = BASE01;
      };
      "ui.cursor.match" = {
        fg = BASE0A;
        modifiers = [ "reversed" ];
      };
      "ui.cursor.select" = {
        fg = BASE0A;
        modifiers = [ "reversed" ];
      };
      "ui.gutter" = {
        bg = BASE00;
      };

      "ui.help" = {
        fg = BASE04;
        bg = BASE01;
      };

      "ui.linenr" = {
        fg = BASE03;
        bg = BASE00;
      };
      "ui.linenr.selected" = {
        fg = BASE04;
        bg = BASE01;
        modifiers = [ "bold" ];
      };

      "ui.menu" = {
        fg = BASE05;
        bg = BASE01;
      };
      "ui.menu.scroll" = {
        fg = BASE03;
        bg = BASE01;
      };
      "ui.menu.selected" = {
        fg = BASE01;
        bg = BASE04;
      };

      "ui.popup" = {
        bg = BASE01;
      };

      "ui.selection" = {
        bg = BASE02;
      };
      "ui.selection.primary" = {
        bg = BASE02;
      };
      "ui.statusline" = {
        fg = BASE04;
        bg = BASE01;
      };
      "ui.statusline.inactive" = {
        bg = BASE01;
        fg = BASE03;
        modifiers = [ "bold" ];
      };
      "ui.statusline.insert" = {
        fg = BASE00;
        bg = BASE0B;
        modifiers = [ "bold" ];
      };
      "ui.statusline.normal" = {
        fg = BASE06;
        bg = BASE02;
        modifiers = [ "bold" ];
      };
      "ui.statusline.select" = {
        fg = BASE00;
        bg = BASE0A;
        modifiers = [ "bold" ];
      };

      "ui.text" = BASE05;
      "ui.text.focus" = BASE05;

      "ui.virtual.indent-guide" = {
        fg = BASE02;
      };
      "ui.virtual.wrap" = {
        fg = BASE02;
      };
      "ui.virtual.inlay-hint" = {
        fg = BASE02;
      };
      "ui.virtual.ruler" = {
        bg = BASE01;
      };
      "ui.virtual.jump-label" = {
        fg = BASE0A;
        modifiers = [ "bold" ];
      };

      "ui.window" = {
        bg = BASE01;
        fg = BASE04;
      };
    };
}
