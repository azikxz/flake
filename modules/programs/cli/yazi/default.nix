{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: use 'yy' wrapper fot cd in yazi directory

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    programs.yazi = {
      enable = true;

      keymap = import ./binds.nix {
        inherit
          pkgs
          lib
          config
          ;
      };

      initLua = import ./lua.nix {
        inherit
          config
          ;
      };

      theme = import ./theme.nix {
        inherit
          lib
          config
          ;
      };
    }
    // import ./plugins.nix {
      inherit
        pkgs
        ;
    }
    // import ./settings/main.nix {
      inherit
        lib
        config
        ;
    };

    xdg.mimeApps = {
      defaultApplications = {
        "inode/directory" = "yazi.desktop";
        "inode/mount-point" = "yazi.desktop";
      };
    };
  };

  hmPackages = with pkgs; [
    ffmpegthumbnailer
    glow
    jq
    (old.ouch.override { enableUnfree = true; })
    wl-clipboard
  ];
}
