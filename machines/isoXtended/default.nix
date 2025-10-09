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

  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";

    makeEfiBootable = true;
    makeUsbBootable = true;

    volumeID = "NIXOS_ISO";
  };

  boot.loader.timeout = lib.mkDefault 0;

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

  environment.systemPackages = with pkgs; [ disko ];

  hm.stylix.enable = true;

  stylix = {
    enable = true;
    overlays.enable = true;

    base16Scheme = inputs.base16."${lib.style.theme}";
    polarity = "dark";
  };

  services.udisks2 = {
    enable = true;

    mountOnMedia = true;
  };
}
