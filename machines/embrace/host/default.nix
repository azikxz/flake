{
  lib,
  ...
}:

let
  inherit (lib.x)
    on
    umport
    ;
in

{
  imports = umport {
    path = ./modules;
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
      network = on;
      power = on;
      sound = on;
      system76 = on;
    };
    services = {
      amneziawg = on // {
        config = ./modules/warp.conf;
      };
      dbus = on;
      fprintd = on;
      flood = on;
      getty = on;
      gvfs = on;
      polkit = on;
      qbittorrent = on;
      tlp = on;
      torrserver = on;
      zram.algo = "zstd";
    };
    programs = {
      common = on;
      hyprland = on;
      steam = on;
      nh = on;
    };
    misc = {
      impermanence = on;
      locales.zone = "Asia/Chita";
      security = on;
      users.passwd = "$2b$05$KxzRemxpLZBhgRObiACMBuZqXgCSdy8OEu2WtGohJkiCiabRhHAtm";
      variables = on;
    };
  };
}
