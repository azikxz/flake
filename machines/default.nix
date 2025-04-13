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
      pass = "/persist/vault/passwords.kdbx";
      steamUnified = "/mnt/SSD/SteamUnified";
    };
    styl = {
      theme = "paradise";
      image = "lampa";
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
    };
    styl = {
      theme = "neo-gen";
      image = "town";
    };
  };

  isoNixtended = {
    sys = {
      hostName = "sus";
      userName = "amogus";
      is = "iso";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    styl = {
      theme = "horizon-dark";
      image = "town";
    };
  };
}
