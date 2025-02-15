{
  jetpure = {
    path = {
      flakeDir = "/persist/flake";
      pass = "/persist/vault/passwords.kdbx";
    };
    sys = {
      hostName = "jetpure";
      userName = "nixzoid";
      is = "desktop";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    styl = {
      theme = "paradise";
      image = "lampa";
    };
  };
  embrace = {
    path = {
      flakeDir = "/persist/flake";
      pass = "/persist/vault/passwords.kdbx";
    };
    sys = {
      hostName = "embrace";
      userName = "huggyer";
      is = "laptop";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    styl = {
      theme = "neo-gen";
      image = "town";
    };
  };
}
