{
  pkgs,
  lib,
  ...
}:

with lib;

#      ..........................
#    ':cccclooooolcccccloooooocccc:,.
#  ':cccccooooooolccccccooooooolccccc,.
# ,;;;;;;cllllllc:;;;;;;clllllll:;;;;;;.
# ,,,,,,,;cccccc;,,,,,,,,cccccc:,,,,,,,.
# .',,,'..':cc:,...,,,'...;cc:,...',,'.
#   .,;:dxl;,;;cxdc,,,;okl;,,,:odc,,,.
#   ,kkkkkx:'..'okkkkkkxxo'...;oxxxxx,
#   ,kkkk:       ...''...       ,dxxx,
#   ,kkk:          .:c'          'xxx;
#   ,kko         .,ccc:;.         :xx;
#   ,kx.         .,;;,,'..         cl'
#   ,kc           .''''.           'l'
#   ,x.       ..............       .l'
#   ,x'      ,oddddddddoolcc,      .l'
#   'xo,...;ldxxxxxxxdollllllc;...'cl'
#   .:ccc:ccccccccc:;;;;;;;;;;;;;;;;,.
#
#   ABSOLUTE EPIC LOGO

mkIf (mac "pcRyazenka") {
  hmPackages = [ pkgs.itch-dl ];
}
