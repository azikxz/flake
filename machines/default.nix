{
  nixos = {
    pcRyazhenka = {
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
    thinkpadT14 = {
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
  };
}
