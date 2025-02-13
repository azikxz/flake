{ inputs, ... }:
{
  flake = import ../../libx {
    inherit inputs;
    sys = {
      hostName = "starship";
      userName = "amogus";
      is = "iso";
      platform = "x86_64-linux";
      ver = "24.05";
    };
    styl = {
      theme = "horizon-dark";
      image = "clouds";
    };
  };
}
