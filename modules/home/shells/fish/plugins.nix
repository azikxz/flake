{
  pkgs,
  ...
}:
with pkgs.fishPlugins;
[
  {
    name = "grc";
    src = grc.src;
  }
  {
    name = "autopair";
    src = autopair.src;
  }
  {
    name = "fzf-fish";
    src = fzf-fish.src;
  }
  {
    name = "git-abbr";
    src = git-abbr.src;
  }
  {
    name = "puffer";
    src = puffer.src;
  }
  {
    name = "colored-man-pages";
    src = colored-man-pages.src;
  }
]
