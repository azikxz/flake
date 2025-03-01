{
  pkgs,
  lib,
  ...
}:

{
  programs = {
    git.package = pkgs.gitMinimal;
  };
  environment.systemPackages = with pkgs; [
    fastfetch
    helix
    disko
    vim
  ];
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen; # idk for best optimize
    loader.timeout = lib.mkDefault 0;
  };
  programs.command-not-found.enable = lib.mkDefault false;
  networking = {
    wireless.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };
}
