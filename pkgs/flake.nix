{
  outputs = x: import ./outputs.nix x;
  inputs.n.url = "github:NixOS/nixpkgs/nixos-unstable";
}
