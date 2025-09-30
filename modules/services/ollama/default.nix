{
  lib,
  ...
}:

with lib;
# INFO: local neuroweb

mkIf (mac "pcRyazenka") {
  services = {
    ollama = {
      enable = true;
      openFirewall = true;

      acceleration = "rocm";

      loadModels = [ ];
    };

    nextjs-ollama-llm-ui.enable = true;
  };
}
