{
  pkgs,
  ...
}:
with pkgs;
let
  mk = name: { ${name} = "${yazi-plugins}/${name}.yazi"; };
  plugin = name: text: {
    "${name}" = toString (writeTextDir "${name}.yazi/init.lua" text) + "/${name}.yazi";
  };
  yazi-plugins = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "71c4fc2e6fa1d6f70c85bf525842d6888d1ffa46";
    hash = "sha256-X3R5bsnzGv1TVXOKdhAyspDMguVAyc9tvCxJlypUUAA=";
  };
in
{
  plugins =
    # builtin
    (mk "max-preview")
    // (mk "hide-preview")
    // (mk "full-border")
    // (mk "chmod")
    // {
      # fetched
      yatline = fetchFromGitHub {
        owner = "imsi32";
        repo = "yatline.yazi";
        rev = "600ed1fb1d04e1292da04280a65f8deca04dc36a";
        hash = "sha256-oHCRScbahGaX8MTVNalNXlxQ7NJN5QKvGHbTXreAWFM=";
      };
      yatline-githead = fetchFromGitHub {
        owner = "imsi32";
        repo = "yatline-githead.yazi";
        rev = "a6377a8b190a8563645e79c6d71e7f398e516c52";
        hash = "sha256-SH2BDk8sHZT1L12gJjVbVBipiTwF/KARkuaJfNGdGXg=";
      };
      ouch = fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "b8698865a0b1c7c1b65b91bcadf18441498768e6";
        hash = "sha256-eRjdcBJY5RHbbggnMHkcIXUF8Sj2nhD/o7+K3vD3hHY=";
      };
      archivemount = fetchFromGitHub {
        owner = "AnirudhG07";
        repo = "archivemount.yazi";
        rev = "d4f3e6a41f955a1e821305ddbc16e571917511f4";
        hash = "sha256-YoEpAQKXBH/W+IUTWaTZU/Q94Dp5mbLxcGuUi9FezYA=";
      };
      mdcat = fetchFromGitHub {
        owner = "GrzegorzKozub";
        repo = "mdcat.yazi";
        rev = "d3d5089d06fe4ed14504726722f89c977f9eb54a";
        hash = "sha256-F6rNLWJxMmTOOlna6lev4m1h559BWftfy6pNoTqVGKw=";
      };
      paste = fetchFromGitHub {
        owner = "crawraps";
        repo = "paste-file.yazi";
        rev = "e59d60cb82ad8d81268b93d20804c44701eca61c";
        hash = "sha256-dV59B5UBBK59TiMv6wfG1EHx9bk3HmpYrQYND1qayTY=";
      };
    }
    # custom
    // (plugin "smart-enter" # lua
      ''
        --- @sync entry
        local function setup(self, opts) self.open_multi = opts.open_multi end
        local function entry(self)
        local h = cx.active.current.hovered
        ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = not self.open_multi })
        end return { entry = entry, setup = setup }
      ''
    )
    // (plugin "smart-paste" # lua
      ''
        --- @sync entry
        return { entry = function()
        local h = cx.active.current.hovered
        if h and h.cha.is_dir then
        ya.manager_emit("enter", {})
        ya.manager_emit("paste", {})
        ya.manager_emit("leave", {}) else
        ya.manager_emit("paste", {}) end end, }
      ''
    )
    // (plugin "smart-tab" # lua
      ''
        --- @sync entry
        return { entry = function()
        local h = cx.active.current.hovered
        ya.manager_emit("tab_create", h and h.cha.is_dir and { h.url } or { current = true })
        end, }
      ''
    );
}
