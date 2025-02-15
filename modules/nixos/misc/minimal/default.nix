{
  lib,
  ...
}:

let
  nahuy = lib.mkDefault lib.x.off;
in

{
  programs.command-not-found = nahuy;
  documentation = nahuy // {
    dev = nahuy;
    doc = nahuy;
    info = nahuy;
    man = nahuy;
    nixos = nahuy;
  };
}
