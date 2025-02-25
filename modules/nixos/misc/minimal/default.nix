{
  lib,
  ...
}:

let
  ye = with lib; mkDefault x.off;
in

{
  programs = {
    nano = ye;
    command-not-found = ye;
  };
  documentation = ye // {
    dev = ye;
    doc = ye;
    info = ye;
    man = ye;
    nixos = ye;
  };
}
