{
  lib,
  ...
}:

with lib;
# INFO: local neuroweb
# with s1mple ui

mkIf (mac "pcRyazenka") {
  persist.dirs = [ "/var/lib/ollama" ];

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
