{
  lib,
  config,
  ...
}:

with lib;

{
  hardware =
    {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    }
    // (optionalAttrs (itIs == "desktop" || itIs == "laptop") {
      amdgpu.initrd.enable = true;

      cpu.amd = {
        ryzen-smu.enable = true;

        updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
      };
    });
}
