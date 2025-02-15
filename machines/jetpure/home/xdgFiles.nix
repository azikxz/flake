{
  lib,
  ...
}:

{
  xdg = {
    dataFile = {
      "bottles/data.yml".text = lib.x.gen "toYAML" {
        custom_bottles_path = "/mnt/HDD/Bottles";
      };
    };
  };
}
