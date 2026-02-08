{
  inputs,
  pkgs,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  sops.secrets = lib.mkSecrets.sops [
    "password"
    "tokens/github"
  ] ./sopsnix.yaml;

  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";

    makeEfiBootable = true;
    makeUsbBootable = true;

    volumeID = "NIXOS_ISO";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader.timeout = lib.mkDefault 0;
  };

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

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    disko
    ntfs3g
  ];

  stylix = {
    image = lib.mkForce null;
    icons.enable = lib.mkForce false;
    cursor = lib.mkForce null;
  };

  services.udisks2 = {
    enable = true;

    mountOnMedia = true;
  };
}
