{
  x,
  inputs,
  ...
}:
{
  imports = with inputs; [ impermanence.nixosModules.impermanence ];
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"
      "/var/lib/chrony"
      "/var/lib/private"
      "/var/lib/iwd"
      "/var/lib/plymouth"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [ "/etc/machine-id" ];
    users.${x.userName} = {
      directories =
        let
          mode = "0777";
          mk = dir: {
            directory = "${dir}";
            inherit mode;
          };
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
          ".local/state/syncthing"
          ".local/share/syncthing"
          ".local/share/qutebrowser"
          # telegram
          ".local/share/64Gram"
          ".cache/stylix-telegram-theme"
          # komikku
          ".local/share/komikku"
          # cli tools
          ".local/share/zoxide"
          # steam
          ".local/share/Steam"
          ".steam"
          ".wine"
          ".srb2"
          # torrent
          ".config/qBittorrent"
          ".local/share/qBittorrent"
          (mk ".ssh")
        ];
      files = [
        ".local/share/fish/fish_history"
      ];
    };
  };
}
