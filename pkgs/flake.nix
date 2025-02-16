{
  outputs = args: import ./outputs.nix args;
  inputs.n.url = "github:NixOS/nixpkgs/nixos-unstable";
}
