{ inputs, pkgs }:

pkgs.writeShellScriptBin "torrDL" ''
  # Скачиваем торрент файл
  wget -O /tmp/temp_torrent_file.torrent "$1"
  # Загружаем торрент файл в TorrServer
  ${
    inputs.torrHelper.packages.${pkgs.system}.default
  }/bin/torr upload_torrent /tmp/temp_torrent_file.torrent
''
