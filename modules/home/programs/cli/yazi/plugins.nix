{
  pkgs,
  ...
}:

with pkgs;
let
  mk = name: { ${name} = "${yazi-plugins}/${name}.yazi"; };
  plugin = n: t: { "${n}" = toString (writeTextDir "${n}.yazi/main.lua" t) + "/${n}.yazi"; };
  yazi-plugins = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "beb586aed0d41e6fdec5bba7816337fdad905a33";
    hash = "sha256-enIt79UvQnKJalBtzSEdUkjNHjNJuKUWC4L6QFb3Ou4=";
  };
in

{
  plugins =
    # builtin
    (mk "chmod")
    // (mk "max-preview")
    // (mk "smart-enter")
    // (mk "full-border")
    // (mk "hide-preview")
    // {
      # fetched
      yatline = fetchFromGitHub {
        owner = "not-mln";
        repo = "yatline.yazi";
        rev = "655facb7c31ddcf96a05185c65dd5b89d5954f2b";
        hash = "sha256-fjapFEaM5ORoJJivrzKxwPM9pe6B9UkVqPfOsUPxpEg=";
      };
      ouch = fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "ce6fb75431b9d0d88efc6ae92e8a8ebb9bc1864a";
        hash = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
      };
      mdcat = fetchFromGitHub {
        owner = "xmozoid";
        repo = "mdcat.yazi";
        rev = "fc6dc5ed991ac650c26aecdf760dfb174d0fb212";
        hash = "sha256-lrPFBZASnBkjfJBeQmZizllMr+IoT0Ws+Axa0FBzR0o=";
      };
      paste = fetchFromGitHub {
        owner = "xmozoid";
        repo = "paste-file.yazi";
        rev = "ad339a798a09452aed5c3067b4ab66cf3ce63f2e";
        hash = "sha256-1nFc1CvM671aTSyIBjWpxDCuxa8T84j4B5jdXhUgkXA=";
      };
      wl-clipboard = fetchFromGitHub {
        owner = "xmozoid";
        repo = "wl-clipboard.yazi";
        rev = "e3eb54b8d7d2e79d53db90bdb509211d7bceae2f";
        hash = "sha256-7eJjNJyC6q+foCF48lwtjCt8fKqHfRWebbp7ymEb5NE=";
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
