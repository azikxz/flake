{
  pkgs,
  lib,
  ...
}:

with pkgs;
let
  inherit (nodePackages_latest)
    prettier
    ;

  vs = n: "vscode-${n}-language-server";

  auto-format = true;
  indent = {
    tab-width = 2;
    unit = "  ";
  };
in

{
  language = [
    {
      # nix
      inherit auto-format indent;
      name = "nix";

      language-servers = [ "nixd" ];

      formatter = {
        command = lib.getExe nixfmt-rfc-style;
      };
    }
    {
      # html
      inherit auto-format indent;
      name = "html";

      language-servers = [ "vscode-html" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "html"
        ];
      };
    }
    {
      # json
      inherit auto-format indent;
      name = "json";

      language-servers = [ "vscode-json" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "json"
        ];
      };
    }
    {
      # jsonc
      inherit auto-format indent;
      name = "jsonc";

      language-servers = [ "vscode-json" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "json"
        ];
      };
    }
    {
      # css
      inherit auto-format indent;
      name = "css";

      language-servers = [ "vscode-css" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "css"
        ];
      };
    }
    {
      # scss
      inherit auto-format indent;
      name = "scss";

      language-servers = [ "vscode-css" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "scss"
        ];
      };
    }
    {
      # markdown
      inherit auto-format indent;
      name = "markdown";

      language-servers = [ "marksman" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "markdown"
        ];
      };
    }
    {
      # typescript
      inherit auto-format indent;
      name = "typescript";

      language-servers = [ "typescript" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "typescript"
        ];
      };
    }
    {
      # typescript
      inherit auto-format indent;
      name = "tsx";

      language-servers = [ "typescript" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "typescript"
        ];
      };
    }
    {
      # yaml
      inherit auto-format indent;
      name = "yaml";

      language-servers = [ "yaml" ];

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "yaml"
        ];
      };
    }
    {
      # python
      inherit auto-format indent;
      name = "python";

      language-servers = [
        "pylsp"
        "pyright"
      ];

      file-types = [
        "py"
        "pyi"
        "py3"
        "pyw"
        ".pythonstartup"
        ".pythonrc"
      ];

      roots = [
        "."
        "pyproject.toml"
        "pyrightconfig.json"
      ];

      comment-token = "#";
      scope = "source.python";
      injection-regex = "python";

      formatter = {
        command = lib.getExe prettier;
        args = [
          "--use-tabs"
          "--parser"
          "python"
        ];
      };
    }
  ];

  language-server =
    let
      vscode = vscode-langservers-extracted;
      typescript = typescript-language-server;
      yaml = yaml-language-server;
    in
    {
      nixd = {
        command = lib.getExe nixd;

        config =
          let
            flake = lib.paths.flakeDir;
          in
          rec {
            nixpkgs.expr = "import (builtins.getFlake \"${flake}\").inputs.nixpkgs { }";
            options = {
              nixos.expr = "(builtins.getFlake \"${flake}\").nixosConfigurations.${lib.system.hostName}.options";
              home-manager.expr = "${options.nixos.expr}.home-manager.users.type.getSubOptions [ ]";
            };
          };
      };
    } # nix
    // {
      typescript.command = lib.getExe typescript;
    } # typescript
    // {
      yaml.command = lib.getExe yaml;
    } # typescript
    // {
      marksman.command = lib.getExe marksman;
    } # markdown
    // {
      vscode-html.command = lib.getExe' vscode (vs "html");
      vscode-json.command = lib.getExe' vscode (vs "json");
      vscode-css.command = lib.getExe' vscode (vs "css");
    } # vscode <lang> server
    // {
      pylsp.command = lib.getExe python312Packages.python-lsp-server;

      pyright = {
        command = lib.getExe pyright;

        args = [ "--stdio" ];

        config = {
          reportMissingTypeStubs = false;

          python.analysis = {
            typeCheckingMode = "basic";
            autoImportCompletions = true;
          };
        };
      };
    } # python
  ;
}
