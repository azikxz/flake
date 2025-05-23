{
  pkgs,
  ...
}:

with pkgs;
let
  s = "share";
  rev = "main";
in

[
  {
    name = "zsh-fzf-tab";
    file = s + "/fzf-tab/fzf-tab.plugin.zsh";
    src = zsh-fzf-tab;
  }
  {
    name = "zsh-autopair";
    file = s + "/zsh/zsh-autopair/autopair.zsh";
    src = zsh-autopair;
  }
]
++ [
  {
    name = "eza-zsh";
    file = "eza-zsh.plugin.zsh";
    src = fetchFromGitHub {
      owner = "MohamedElashri";
      repo = "eza-zsh";
      sha256 = "sha256-ee56D48unp/Bm1EA2/pYYYJZ8Fdtbu0LsUGHfGlRNK8=";
      inherit rev;
    };
  }
  {
    name = "helix-mode";
    file = "helix-mode.zsh";
    src = fetchFromGitHub {
      owner = "allomanta";
      repo = "zsh-helix-mode";
      rev = "f5e6cb94fa77f5fa0762b9b2c7c818e8ae87d22e";
      hash = "sha256-oDRk9JK5agM1Izc6FWf+i6bRKhK3uohG9Cnco3dJwP8=";
    };
  }
]
