{
  x,
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
      enable = mkBool;
      amdvlk.enable = mkBool;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware = mkIf cfg.enable {
        graphics = True // {
          enable32Bit = true;
        };
        amdgpu.initrd = True;
        cpu.amd = {
          updateMicrocode = with config.hardware; lib.mkDefault enableRedistributableFirmware;
          ryzen-smu = True;
        };
      };
    })
    (mkIf cfg.amdvlk.enable {
      hardware.amdgpu.amdvlk = True // {
        support32Bit = True;
        supportExperimental = False;
      };
    })
  ];
}
