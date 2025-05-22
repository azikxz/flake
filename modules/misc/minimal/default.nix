{
  lib,
  ...
}:

with lib;
let
  off = mkDefault { enable = false; };
in

{
  programs = {
    nano = off;
    command-not-found = off;
  };

  documentation = {
    dev = off;
    doc = off;
    info = off;
    man = off;
    nixos = off;
  };

  hm = {
    news.display = "silent";

    programs.man = off;

    manual = {
      html = off;
      json = off;
      manpages = off;
    };
  };
}
