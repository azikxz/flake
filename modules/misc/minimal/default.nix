{
  lib,
  ...
}:

with lib;
let
  off = mkDefault { enable = false; };
in
# INFO: fuck it

{
  programs = genAttrs [
    "nano"
    "command-not-found"
  ] (n: off);

  documentation = genAttrs [
    "dev"
    "doc"
    "info"
    "man"
    "nixos"
  ] (n: off);

  hm = {
    news.display = "silent";

    programs.man = off;

    manual = genAttrs [
      "html"
      "json"
      "manpages"
    ] (n: off);
  };
}
