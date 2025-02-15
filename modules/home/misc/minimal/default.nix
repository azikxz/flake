{
  lib,
  ...
}:

with lib.x;

{
  news.display = "silent";
  programs.man = off;
  manual = {
    html = off;
    json = off;
    manpages = off;
  };
}
