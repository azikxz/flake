{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# declarative, ye

mkIf false {
  persist.dirs = [ "/var/lib/flatpak" ];

  services.flatpak = {
    enable = true;

    update.onActivation = true;
    uninstallUnmanaged = true;

    remotes = mkOptionDefault [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];

    packages = attrValues {
      sober = (
        mkIf false {
          flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
          sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
        }
      ); # roblox (android edition)

      hytale = (
        mkIf false rec {
          appId = "com.hytale.Launcher";
          sha256 = "0pw1f4p5902hd9am1hnvmxy7271vf2xgyvszdj17zndwp56ij5l8";

          bundle = "${pkgs.fetchurl {
            url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
            inherit
              sha256
              ;
          }}";
        }
      ); # 7 years of waiting, finally
    };

    overrides.global = {
      Context = {
        filesystems = [
          "${config.users.users.${system.userName}.home}:ro"
          "/media/disks:rw"
        ];

        sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
      };
    };
  };
}
