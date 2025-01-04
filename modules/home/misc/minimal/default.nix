{ x, ... }:
with x;
{
  news.display = "silent";
  programs.man = False;
  manual = {
    html = False;
    json = False;
    manpages = False;
  };
}
