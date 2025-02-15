{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.hardware.amd;
in

{
  options = {
    module.hardware.amd = {
      enable = mkBool false;
      amdvlk.enable = mkBool false;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware = mkIf cfg.enable {
        graphics = on // {
          enable32Bit = true;
        };
        amdgpu.initrd = on;
        cpu.amd = {
          updateMicrocode = with config.hardware; lib.mkDefault enableRedistributableFirmware;
          ryzen-smu = on;
        };
      };
    })
    (mkIf cfg.amdvlk.enable {
      hardware.amdgpu.amdvlk = on // {
        support32Bit = on;
        supportExperimental = off;
      };
    })
  ];
}
