{
  pkgs,
  ...
}:

with pkgs;

[
  {
    name = "zsh-autopair";
    file = "share/zsh/zsh-autopair/autopair.zsh";
    src = zsh-autopair;
  }

  {
    name = "zsh-helix-mode";
    file = "share/zsh-helix-mode/zsh-helix-mode.plugin.zsh";
    src = zsh-helix-mode;
  }
]
