{ lib, ... }:

let
  inherit (lib.x) on off umport;
in

{
  imports = umport {
    path = ./.;
    exclude = [ ./default.nix ];
  };
  module = {
    themes.stylix = on;
    base = on;
    hardware = {
      amd = on;
      bluetooth = on;
      boot = on // {
        plymouth = on;
      };
      impermanence = off;
      network = on;
      power = off;
      sound = on;
      system76 = off;
    };
    services = {
      amneziawg = on;
      autocpu = off;
      dbus = on;
      deluge = off;
      getty = on;
      gvfs = on;
      polkit = on;
      printing = off;
      tailscale = on;
      tlp = off;
      torrserver = on;
      transmission = off // {
        tui = off;
      };
      zram.algo = "zstd";
    };
    programs = {
      common = on;
      hamachi = on;
      hyprland = on;
      steam = on;
      sway = off;
    };
    misc = {
      console = off;
      locales.zone = "Asia/Chita";
      protonmail = off;
      security = on;
      terraria = off;
      users.passwd = "$2a$05$yafhLZqwJZaPtcvo1alcQekxot7ef8m9rbYIbIH5AKCywCOZK3URy";
      variables = on;
    };
  };
}
