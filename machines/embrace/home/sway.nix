let
  m = "Mod4";
  X = "exec";
in
{
  module.wm.sway = {
    programs = {
      "${m}+b" = "${X} qutebrowser";
      "${m}+v" = "${X} telegram-desktop";
      "${m}+n" = "${X} kitty -T Explorer yazi";
      "${m}+u" = "${X} onlyoffice-desktopeditors";
    };
  };
}
