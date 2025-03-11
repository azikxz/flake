{
  inputs,
  ...
}:

let
  mkFirefoxModule = import "${inputs.home.outPath}/modules/programs/firefox/mkFirefoxModule.nix";
  modulePath = [
    "programs"
    "zen-browser"
  ];
in

{
  imports = [
    (mkFirefoxModule {
      inherit modulePath;
      name = "zen";
      wrappedPackageName = "zen-browser";
      visible = true;
      platforms.linux = {
        vendorPath = ".zen";
        configPath = ".zen";
      };
    })
  ];
}
