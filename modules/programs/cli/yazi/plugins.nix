{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    writeTextDir
    fetchFromGitHub
    ;

  mkPlugin = n: {
    "${n}" = (yazi-plugins + "/" + n + ".yazi");
  };

  plugin = n: t: {
    "${n}" = toString (writeTextDir (n + ".yazi" + "/" + "main.lua") t) + ("/" + n + ".yazi");
  };

  yazi-plugins = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "beb586aed0d41e6fdec5bba7816337fdad905a33";
    hash = "sha256-enIt79UvQnKJalBtzSEdUkjNHjNJuKUWC4L6QFb3Ou4=";
  };
in

{
  plugins =
    {
      inherit (pkgs.yaziPlugins)
        jump-to-char
        full-border
        smart-enter
        yatline
        chmod
        ;
    }
    # builtin
    // (mkPlugin "max-preview")
    // (mkPlugin "hide-preview")
    // {
      # fetched
      yatline-tab-path = fetchFromGitHub {
        owner = "blackdaemon";
        repo = "yatline-tab-path.yazi";
        rev = "101fe7c8a979dbdf498259cc773dc8bd781a8733";
        hash = "sha256-wV5YXm31zMsG7e/YhWa+72eLYC/QmBgjweKFuIn5BpA=";
      };
      ouch = fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "2496cd9ac2d1fb52597b22ae84f3af06c826a86d";
        hash = "sha256-OsNfR7rtnq+ceBTiFjbz+NFMSV/6cQ1THxEFzI4oPJk=";
      };
      glow = fetchFromGitHub {
        owner = "Reledia";
        repo = "glow.yazi";
        rev = "2da96e3ffd9cd9d4dd53e0b2636f83ff69fe9af0";
        hash = "sha256-4krck4U/KWmnl32HWRsblYW/biuqzDPysrEn76buRck=";
      };
      wl-clipboard = fetchFromGitHub {
        owner = "xmozoid";
        repo = "wl-clipboard.yazi";
        rev = "e3eb54b8d7d2e79d53db90bdb509211d7bceae2f";
        hash = "sha256-7eJjNJyC6q+foCF48lwtjCt8fKqHfRWebbp7ymEb5NE=";
      };
      office = fetchFromGitHub {
        owner = "macydnah";
        repo = "office.yazi";
        rev = "d1e3e51857c109fbfc707ab0f9f383dc98b9795f";
        hash = "sha256-ORcexu1f7hb7G4IyzQIfGlCkH3OWlk4w5FtZrbXkR40=";
      };
    }
    # custom
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
    // (plugin "folder-screenshots" # lua
      ''
        local function setup() ps.sub("cd", function()
        local cwd = cx.active.current.cwd if cwd:ends_with("Pictures/screenshots")
        then ya.mgr_emit("sort", { "mtime", reverse = true, dir_first = false })
        else ya.mgr_emit("sort", { "naturally", reverse = false, dir_first = true })
        end end) end return { setup = setup }
      ''
    )
    // (plugin "parent-arrow" # lua
      ''
        --- @sync entry
        local function entry(_, job)
        local parent = cx.active.parent if not parent then return end
        local offset = tonumber(job.args[1]) if not offset then return
        ya.err(job.args[1], 'is not a number') end
        local start = parent.cursor + 1 + offset
        local end_ = offset < 0 and 1 or #parent.files
        local step = offset < 0 and -1 or 1
        for i = start, end_, step do local target = parent.files[i]
        if target and target.cha.is_dir then return
        ya.mgr_emit("cd", { target.url }) end end end
        return { entry = entry }
      ''
    )
    // (plugin "smart-tab" # lua
      ''
        --- @sync entry
        return { entry = function() local h = cx.active.current.hovered
        ya.manager_emit("tab_create", h and h.cha.is_dir and
        { h.url } or { current = true }) end, }
      ''
    );
}
