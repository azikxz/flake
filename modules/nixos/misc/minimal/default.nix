{
  x,
  lib,
  ...
}:
let
  nahuy = lib.mkDefault x.off;
in
{
  programs.command-not-found = nahuy;
  documentation = x.off // {
    dev = nahuy;
    doc = nahuy;
    info = nahuy;
    man = nahuy;
    nixos = nahuy;
  };
}
