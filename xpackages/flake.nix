{
  outputs = x: import ./outputs.nix x;
  inputs.nix.url = "github:NixOS/nixpkgs/nixos-unstable";
}
