{
  x,
  ...
}:
{
  xdg = {
    dataFile = {
      "bottles/data.yml".text = x.gen "toYAML" {
        custom_bottles_path = "/mnt/HDD/Bottles";
      };
    };
  };
}
