{
  edit = [
    {
      run = ''hx "$@"'';
      desc = "Open in editor";
      block = true;
    }
  ];
  play = [
    {
      run = ''mpv --fs "$@"'';
      desc = "Open video";
      orphan = true;
      block = true;
    }
  ];
  image = [
    {
      run = ''swayimg "$@"'';
      desc = "Open image";
      orphan = true;
      block = true;
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
      orphan = true;
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
      orphan = true;
    }
  ];
  exe = [
    {
      run = ''wine "$@"'';
      desc = "Open via wine";
      orphan = true;
    }
  ];
  open = [
    {
      run = ''"xdg-open "$@"'';
      desc = "Open via xdg";
    }
  ];
}
