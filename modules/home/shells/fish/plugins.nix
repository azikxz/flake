{
  pkgs,
  ...
}:

let
  mk = n: p: {
    name = n;
    src = p.src;
  };
in

(with pkgs.fishPlugins; [
  (mk "colored-man-pages" colored-man-pages)
  (mk "autopair-fish" autopair-fish)
  (mk "fzf-fish" fzf-fish)
  (mk "git-abbr" git-abbr)
  (mk "puffer" puffer)
  (mk "grc" grc)
])
