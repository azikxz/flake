{
  pcRyazenka = {
    system = {
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
      image = "gasStation";
    };
  };

  thinkpadT14 = {
    system = {
      hostName = "blackmamba";
      userName = "toneus";
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
      image = "carGirls";
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
