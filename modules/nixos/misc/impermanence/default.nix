{
  inputs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.impermanence;
in

{
  options = {
    module.misc.impermanence = {
      enable = mkBool false;
    };
    impermanence = with types; {
      dirs = mkList.str [ ];
      files = mkList.str [ ];
      user = {
        dirs = mkList.str [ ];
        files = mkList.str [ ];
      };
    };
  };

  imports = with inputs; [ impermanence.nixosModules.impermanence ];
  config = mkIf cfg.enable {
    boot.initrd = import ./initrd.nix {
      inherit
        lib
        ;
    };
    fileSystems.${x.path.impermanence}.neededForBoot = true;
    environment.persistence.${x.path.impermanence + "/system"} = with config.impermanence; {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/timers"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ] ++ dirs;
      files = [
        "/etc/machine-id"
      ] ++ files;
      users.${x.sys.userName} = {
        directories = [ ] ++ user.dirs;
        files = [ ] ++ user.files;
      };
    };
  };
}
