{
  inputs,
}:

# INFO:
# > nix run .#firefox-addons.run -- \
#     packages/firefox-addons/input.json \
#     packages/firefox-addons/packages.nix
#
# generates firefox addons

inputs.addons2nix.packages.x86_64-linux.default
