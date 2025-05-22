{
  pkgs,
  ...
}:

{
  environment.systemPackages = [ pkgs.pulsemixer ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    pulse = {
      enable = true;
    };

    wireplumber = {
      enable = true;
    };

    alsa = {
      enable = true;
      support32Bit = true;
    };

    lowLatency.enable = true;
  };
}
