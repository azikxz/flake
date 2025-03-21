{
  lib,
  ...
}:

let
  inherit (lib.x) on umport;
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
      network = on;
      sound = on;
    };
    services = {
      amneziawg = on // {
        config = ./warp.conf;
      };
      dbus = on;
      flood = on;
      getty = on;
      gvfs = on;
      polkit = on;
      qbittorrent = on;
      tailscale = on;
      torrserver = on;
      zram.algo = "zstd";
    };
    programs = {
      common = on;
      hyprland = on;
      nh = on;
      steam = on;
    };
    misc = {
      locales.zone = "Asia/Chita";
      security = on;
      users.passwd = "$2a$05$yafhLZqwJZaPtcvo1alcQekxot7ef8m9rbYIbIH5AKCywCOZK3URy";
      variables = on;
    };
  };
}
