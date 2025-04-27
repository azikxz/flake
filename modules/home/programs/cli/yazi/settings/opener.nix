{
  lib,
  config,
  config',
  ...
}:

let
  inherit (lib) mkIf;
in

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
  exe =
    let
      type = if config.module.games.umu.enable then "umu-run" else "wine";
    in
    mkIf config.module.games.umu.enable [
      {
        run = ''${type} "$@"'';
        desc = "Open via ${type}";
        orphan = true;
      }
    ];
  native = mkIf config'.programs.steam.enable [
    {
      run = ''steam-run "$@"'';
      desc = "Open native bin";
      orphan = true;
    }
  ];
  open = [
    {
      run = "xdg-open \"$@\"";
      desc = "Open via xdg";
    }
  ];
}
