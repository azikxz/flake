{
  lib,
  ...
}:

with lib;
# INFO:
# webapps via ff
#
# webapps - websites wrapped in app
# like electron but not chromium

mkIf false {
  programs.firefoxpwa = {
    enable = true;

    settings = { };
    # too lazy for do this, man...
  };
}
