{ x, ... }:
let
  inherit (x) True False umport;
in
{
  imports = umport {
    exclude = [ ./default.nix ];
    path = ./.;
  };
  module = {
    themes.stylix = True;
    base = True;
    hardware = {
      amd = True // {
        amdvlk = False;
      };
      bluetooth = True;
      boot = True // {
        plymouth = True;
      };
      disko = True;
      impermanence = False;
      network = True;
      power = False;
      sound = True;
      system76 = False;
    };
    services = {
      amneziawg = True // {
        service = False;
        config = "topor";
      };
      autocpu = False;
      dbus = True;
      deluge = False;
      getty = True;
      gvfs = True;
      polkit = True;
      printing = False;
      tailscale = False;
      tlp = False;
      transmission = True // {
        tui = True;
      };
      zapret = False;
      zram = True // {
        algo = "zstd";
      };
    };
    programs = {
      common = True;
      hamachi = False;
      hyprland = True;
      steam = True;
      sway = False;
      torrserver = True;
    };
    virt = {
      podman = True;
    };
    misc = {
      console = False;
      locales = True // {
        zone = "Asia/Chita";
      };
      minimal = True;
      protonmail = False;
      security = True;
      terraria = False;
      users = True // {
        shell = "fish";
      };
      variables = True;
    };
  };
}
