{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
in
with pkgs;
{
  module.shells = {
    abbrs = {
      "-h" = "--help";
    };
    alias = {
      rebuild = "nh os switch";
      # helpful
      e = "$EDITOR";
      c = "clear";
      x = "exit";

      # useful
      ca = "cava";
      cat = "bat";
      pmx = "pulsemixer";
      blt = "bluetuith";
      icat = "kitten icat";

      # tops
      btop = "btop";
      ntop = "nvtop -i";

      # clock
      ter = "${getExe tenki} --mode rain --wind disable --timer-color cyan -f 80";
      tes = "${getExe tenki} --mode snow --wind disable --timer-color yellow -f 80";
      tem = "${getExe tenki} --mode meteor --wind disable --timer-color red -f 80";

      # gen base16
      baseL = "${getExe flavours} generate light --stdout -a=azikx";
      baseD = "${getExe flavours} generate dark --stdout -a=azikx";

      # vpn
      vpnUp = "sudo awg-quick up";
      vpnDo = "sudo awg-quick down";

      # lutgen
      lut = "${getExe lutgen} apply -p paradise";
      lutall = "${getExe lutgen} apply -p paradise ./*";
    };
  };
}
