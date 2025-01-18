{
  x,
  ...
}:
let
  inherit (x) True False umport;
in
{
  imports = umport {
    path = ./.;
    include = [ ../impermanence.nix ];
    exclude = [ ./default.nix ];
  };
  module = {
    themes.stylix = True;
    base = True;
    hardware = {
      amd = True;
      bluetooth = True;
      boot = True // {
        plymouth = True;
      };
      impermanence = True;
      network = True;
      power = True;
      sound = True;
      system76 = True;
    };
    services = {
      amneziawg = True;
      autocpu = True;
      dbus = True;
      deluge = False;
      getty = True;
      gvfs = True;
      polkit = True;
      printing = False;
      tailscale = False;
      tlp = True;
      transmission = False // {
        tui = False;
      };
      zram.algo = "zstd";
    };
    programs = {
      common = True;
      hamachi = False;
      hyprland = True;
      steam = False;
      sway = False;
      torrserver = False;
    };
    misc = {
      console = False;
      locales.zone = "Asia/Chita";
      minimal = True;
      protonmail = False;
      security = True;
      terraria = False;
      users = True;
      variables = True;
    };
  };
}
