{
  pcRyazenka = {
    system = {
      hostName = "jetpure";
      userName = "nixzoid";
      platform = "x86_64-linux";
      version = "24.05";
    };
    paths = {
      winePrefix = "/media/disks/fastBitch/UnifiedPrefix";
      flakeDir = "/etc/nixos";
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
    style = {
      theme = "classic";
      image = "inanis";
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
