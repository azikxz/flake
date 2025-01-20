{
  x,
  ...
}:
let
  inherit (x) on off umport;
in
{
  imports = umport {
    path = ./.;
    include = [ ../impermanence.nix ];
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
      autocpu = off;
      dbus = on;
      deluge = off;
      getty = on;
      gvfs = on;
      polkit = on;
      printing = off;
      tailscale = off;
      tlp = on;
      transmission = off // {
        tui = off;
      };
      zram.algo = "zstd";
    };
    programs = {
      common = on;
      hamachi = off;
      hyprland = on;
      steam = on;
      sway = off;
      torrserver = off;
    };
    misc = {
      console = off;
      locales.zone = "Asia/Chita";
      minimal = on;
      protonmail = off;
      security = on;
      terraria = off;
      users = on;
      variables = on;
    };
  };
}
