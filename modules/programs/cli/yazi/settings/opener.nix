{
  lib,
  config,
  ...
}:

with lib;

{
  edit = [
    {
      run = ''${config.hm.home.sessionVariables.EDITOR} "$@"'';
      desc = "Open in editor";
      block = true;
    }
  ];

  play = [
    {
      run = ''mpv --fs "$@"'';
      desc = "Open video in MPV";
    }
  ];

  image = [
    {
      run = ''swayimg "$@"'';
      desc = "Open image in swayimg";
    }
  ];

  torrent = [
    {
      run = ''qbt torrent add file "$@"'';
      desc = "Add torrent to qBittorrent";
      orphan = true;
    }
  ];

  office = [
    {
      run = ''libreoffice "$@"'';
      desc = "Open document in Libreoffice";
      orphan = true;
    }
  ];

  officePdf = [
    {
      run = ''zaread "$@"'';
      desc = "Open document in Zathura";
      orphan = true;
    }
  ];

  pdf = [
    {
      run = ''zathura "$@"'';
      desc = "Open pdf in Zathura";
    }
  ];

  extract = [
    {
      run = ''ouch d -y "$@"'';
      desc = "Extract files via ouch";
    }
  ];

  kdbx = [
    {
      run = ''keepassxc "$@"'';
      desc = "Open keepass password db";
    }
  ];

  prism = [
    {
      run = ''prismlauncher "$@"'';
      desc = "Import modpack to Prismlauncher";
    }
  ];

  exe = [
    {
      run = ''umu-run "$@"'';
      desc = "Open windows exe via umu-run";
      orphan = true;
    }
  ];

  native = mkIf config.programs.steam.enable [
    {
      run = ''steam-run "$@"'';
      desc = "Open native bin via steam-run";
      orphan = true;
      block = true;
    }
  ];

  open = [
    {
      run = ''xdg-open "$@"'';
      desc = "Open via xdg-open";
    }
  ];
}
