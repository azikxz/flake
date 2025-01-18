{
  x,
  inputs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.flatpak;
in
{
  options = {
    module.services.flatpak = {
      enable = mkBool;
    };
  };

  imports = with inputs; [ nix-flatpak.nixosModules.nix-flatpak ];
  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      update.onActivation = true;
      uninstallUnmanaged = true;
      remotes = lib.mkOptionDefault [
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];
      packages = [
        {
          flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
          sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
        }
      ];
      overrides.global = {
        Context = {
          filesystems = [ "/home:ro" ];
          sockets = [
            "wayland"
            "!x11"
            "!fallback-x11"
          ];
        };
      };
    };
  };
}
