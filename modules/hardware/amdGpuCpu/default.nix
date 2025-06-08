{
  pkgs,
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

        extraPackages = with pkgs; [ rocmPackages.clr.icd ];
      };
    }
    // (optionalAttrs true {
      amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
      };

      cpu.amd = {
        ryzen-smu.enable = true;

        updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
      };
    });

  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
    ROC_ENABLE_PRE_VEGA = 1;
  };
}
