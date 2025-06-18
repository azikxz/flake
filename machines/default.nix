{
  pcRyazenka = {
    system = {
      itIs = "desktop";
      hostName = "jetpure";
      userName = "nixzoid";
      platform = "x86_64-linux";
      version = "24.05";
    };
    paths = {
      flakeDir = "/etc/nixos";
      winePrefix = "/media/disks/fastBitch/SteamUnified";
      persist = null;
    };
    style = {
      theme = "paradise";
      image = "flowerOrange";
    };
  };

  thinkpadT14 = {
    system = {
      itIs = "laptop";
      hostName = "embrace";
      userName = "huggyer";
      platform = "x86_64-linux";
      version = "24.05";
    };
    paths = {
      flakeDir = "/persist/flake";
      winePrefix = "/persist/proton-prefix";
      persist = "/persist";
    };
    style = {
      theme = "neoGenesis";
      image = "townChristmas";
    };
  };

  # isoNixtended = {
  #   sys = {
  #     hostName = "sus";
  #     userName = "amogus";
  #     is = "iso";
  #     platform = "x86_64-linux";
  #     ver = "24.05";
  #   };
  #   styl = {
  #     theme = "horizon-dark";
  #     image = "town";
  #   };
  # };
}
