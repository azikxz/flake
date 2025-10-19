{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    yazi-plugins
    yaziPlugins
    writeTextDir
    fetchFromGitHub
    ;

  plugin = n: t: {
    "${n}" = (writeTextDir "${n}.yazi/main.lua" t) + "/${n}.yazi";
  };
in

{
  plugins = {
    inherit (yaziPlugins)
      chmod
      full-border
      git
      jump-to-char
      mount
      ouch
      restore
      smart-enter
      toggle-pane
      yatline
      ;

    inherit (yazi-plugins)
      glow
      office
      wl-clipboard
      ;
  }
  //

    # fetched
    {
      save-clipboard-to-file = fetchFromGitHub {
        owner = "boydaihungst";
        repo = "save-clipboard-to-file.yazi";
        rev = "40de82fec9f46d3c3d1dc8907d0ca3fa6ca8c8f1";
        hash = "sha256-5wtSjwg6RvbIuODwQOHJ+bHhPjhn0UyRWzPngdS8uQM=";
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
