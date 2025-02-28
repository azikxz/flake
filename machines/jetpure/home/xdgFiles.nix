{
  lib,
  ...
}:

{
  xdg = {
    dataFile = {
      "bottles/data.yml".text = lib.x.toGen "toYAML" {
        custom_bottles_path = "/mnt/HDD/Bottles";
      };
    };
  };
}
