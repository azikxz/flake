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
      winePrefix = "/media/disks/fastBitch/UnifiedPrefix";
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
      flakeDir = "/etc/nixos";
      winePrefix = "/persist/UnifiedPrefix";
      persist = "/persist";
    };
    style = {
      theme = "classic";
      image = "tapestry";
    };
  };

  isoXtended = {
    system = {
      hostName = "sus";
      userName = "amogus";
      platform = "x86_64-linux";
      version = "24.05";
    };
    style = {
      theme = "horizonDark";
      image = "witchCar";
    };
  };
}
