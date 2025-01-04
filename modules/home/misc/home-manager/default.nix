{ x, ... }:
with x;
{
  programs.home-manager = True;
  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = ver;
  };
}
