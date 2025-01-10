{
  x,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) getExe;
  inherit (pkgs.nodePackages_latest) prettier;
  indent = {
    tab-width = 2;
    unit = "  ";
  };
  auto-format = true;
in
{
  programs.helix = with pkgs; {
    languages = {
      language = [
        {
          # nix
          inherit auto-format indent;
          name = "nix";
          language-servers = [
            "nixd"
            "nil"
          ];
          formatter.command = "${getExe nixfmt-rfc-style}";
        }
        {
          # html
          inherit auto-format indent;
          name = "html";
          language-servers = [ "vscode-html" ];
          formatter = {
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            command = "${getExe prettier}";
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
            "ruff"
          ];
          shebangs = [ "${getExe python39}" ];
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
            command = "${getExe prettier}";
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
            command = "${getExe nixd}";
          };
        } # nix
        // {
          typescript.command = "${getExe typescript}";
        } # typescript
        // {
          yaml.command = "${getExe yaml}";
        } # typescript
        // {
          marksman.command = "${getExe marksman}";
        } # markdown
        // {
          vscode-html.command = "${vscode}/bin/vscode-html-language-server";
          vscode-json.command = "${vscode}/bin/vscode-json-language-server";
          vscode-css.command = "${vscode}/bin/vscode-css-language-server";
        } # vscode <lang> server
        // {
          ruff.command = "${getExe ruff-lsp}";
          pyright = {
            command = "${getExe pyright}";
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
    };
  };
}
