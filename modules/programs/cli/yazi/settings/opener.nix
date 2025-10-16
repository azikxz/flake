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
      desc = "Open video";
    }
  ];

  image = [
    {
      run = ''swayimg "$@"'';
      desc = "Open image";
    }
  ];

  office = [
    {
      run = ''libreoffice "$@"'';
      desc = "Open document";
      orphan = true;
    }
  ];

  pdf = [
    {
      run = ''zathura "$@"'';
      desc = "Open PDF";
    }
  ];

  extract = [
    {
      run = ''ouch d -y "$@"'';
      desc = "Extract files";
    }
  ];

  kdbx = [
    {
      run = ''keepassxc "$@"'';
      desc = "Open passwords db";
    }
  ];

  prism = [
    {
      run = ''prismlauncher "$@"'';
      desc = "Import modpack to prismlauncher";
    }
  ];

  exe = [
    {
      run = ''umu-run "$@"'';
      desc = "Open via umu-run";
      orphan = true;
    }
  ];

  native = mkIf config.programs.steam.enable [
    {
      run = ''steam-run "$@"'';
      desc = "Open native bin";
      orphan = true;
      block = true;
    }
  ];

  open = [
    {
      run = ''xdg-open "$@"'';
      desc = "Open via xdg";
    }
  ];
}
