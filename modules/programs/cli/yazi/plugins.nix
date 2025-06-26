{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    yaziPlugins
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
      inherit (yaziPlugins)
        chmod
        full-border
        jump-to-char
        restore
        smart-enter
        yatline
        ;
    }

    # builtin
    // (mkPlugin "max-preview")
    // (mkPlugin "hide-preview")
    //

      # fetched
      {
        ouch = fetchFromGitHub {
          owner = "ndtoan96";
          repo = "ouch.yazi";
          rev = "1ee69a56da3c4b90ec8716dd9dd6b82e7a944614";
          hash = "sha256-4KZeDkMXlhUV0Zh+VGBtz9kFPGOWCexYVuKUSCN463o=";
        };

        glow = fetchFromGitHub {
          owner = "tiejunhu";
          repo = "glow.yazi";
          rev = "eec50c71586e1649b6655d9a2d349cec245280e8";
          hash = "sha256-ppsYr26T3iF5UVFq+EPIe/Ai7GgAj0Ry1yu0440tQtc=";
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
          rev = "4002d368c09841d5722d55720fd29c2eba05300f";
          hash = "sha256-XE+EfVPsO09zG8qYEhN6O95mS9NJlTdOd4Gsem2KtPI=";
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
