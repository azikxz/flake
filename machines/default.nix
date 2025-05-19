{
  pcRyazenka = {
    sys = {
      hostName = "jetpure";
      userName = "nixzoid";
      is = "desktop";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    path = {
      flake = "/persist/flake";
      pass = "/persist/passwords/passwords.kdbx";
      steamUnified = "/media/disks/fastBitch/SteamUnified";
    };
    styl = {
      theme = "horizonDark";
      image = "hanabiFireworks";
    };
  };

  thinkpadT14 = {
    sys = {
      hostName = "embrace";
      userName = "huggyer";
      is = "laptop";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    path = {
      flake = "/persist/flake";
      pass = "/persist/vault/passwords.kdbx";
      steamUnified = "/persist/proton-prefix";
      impermanence = "/persist";
    };
    styl = {
      theme = "neoGenesis";
      image = "townChristmas";
    };
  };
}
