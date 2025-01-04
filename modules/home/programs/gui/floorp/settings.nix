{ x, ... }:
with x;
{
  programs.floorp.profiles.${userName}.settings = {
    # OTHER
    "extensions.autoDisableScopes" = 0;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "svg.context-properties.content.enabled" = true;
    "ui.key.menuAccessKeyFocuses" = false;
  };
}
