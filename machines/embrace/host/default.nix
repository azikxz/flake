{
  lib,
  ...
}:

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
      impermanence = on;
      network = on;
      power = on;
      sound = on;
      system76 = on;
    };
    services = {
      amneziawg = on;
      dbus = on;
      fprintd = on;
      getty = on;
      gvfs = on;
      polkit = on;
      tlp = on;
      zram.algo = "zstd";
    };
    programs = {
      common = on;
      hyprland = on;
      steam = on;
    };
    misc = {
      locales.zone = "Asia/Chita";
      security = on;
      users.passwd = "$2b$05$KxzRemxpLZBhgRObiACMBuZqXgCSdy8OEu2WtGohJkiCiabRhHAtm";
      variables = on;
    };
  };
}
