{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    inputs:
    import ./outputs.nix {
      inherit inputs;
      list = [
        "qTransPop"
        "qTransPag"
        "base16-preview"
        "torrserver"
        "anicliru"
        "canvas"
        "torque"
        "lowfi"
      ];
    };
}
