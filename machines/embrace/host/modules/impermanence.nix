{
  lib,
  inputs,
  ...
}:

{
  imports = with inputs; [ impermanence.nixosModules.impermanence ];
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories =
      let
        var = "/var/";
        varLib = var + "lib/";
      in
      [
        "/media"
        "/etc/NetworkManager/system-connections"
        (var + "log")
        (varLib + "bluetooth")
        (varLib + "flood")
        (varLib + "qBittorrent")
        (varLib + "nixos")
        (varLib + "systemd/coredump")
        (varLib + "NetworkManager")
        (varLib + "chrony")
        (varLib + "private")
        (varLib + "iwd")
        (varLib + "plymouth")
        {
          directory = varLib + "colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
    files = [ "/etc/machine-id" ];
    users.${lib.x.sys.userName} = {
      directories =
        let
          mode = "0777";
          mk = dir: {
            directory = "${dir}";
            inherit mode;
          };
          cache = ".cache/";
          local = ".local/";
          lState = local + "state/";
          lShare = local + "share/";
        in
        [
          # xdg dirs
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
          # syncthing
          (lState + "syncthing")
          (lShare + "syncthing")
          (lShare + "qutebrowser")
          # telegram
          (lShare + "64Gram")
          (cache + "stylix-telegram-theme")
          # komikku
          (lShare + "komikku")
          # cli tools
          (lShare + "zoxide")
          # steam
          (lShare + ".local/share/Steam")
          ".steam"
          ".srb2"
          ".wine-pfx"
          (mk ".ssh")
        ];
      files = [
        ".local/share/fish/fish_history"
      ];
    };
  };
}
