{
  pkgs,
  ...
}:

{
  programs = {
    git.package = pkgs.gitMinimal;
  };
  environment.systemPackages = with pkgs; [
    helix
    disko
    vim
  ];
}
