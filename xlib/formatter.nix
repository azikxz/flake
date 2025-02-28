{
  forAllSystems,
  pkgs,
}:

forAllSystems (system: {
  ${system} = pkgs.nixfmt-rfc-style;
})
