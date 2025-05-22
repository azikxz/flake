{
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

# css
''
  * {
    font-family: "${config.stylix.fonts.monospace.name}";
    font-weight: bold;
    font-size: 16px;
  }

  window#waybar {
    border-top: 3px solid ${base01};
    background-color: ${base00};
    color: ${base05};
  }

  window#waybar > box {
    margin: 5px 0px 0px 0px;
    background-color: ${base00};
    border-top: 0px;
    border-bottom: 0;
    border-style: solid;
    border-color: #3C3836;
  }

  /* workspaces */
  #workspaces button {
    background-color: ${base03};
    border-radius: 20px;
    margin: 2px;
    padding: 0px;
    padding-right: 6px;
    padding-left: 6px;
    color: ${base05};
    min-height: 25px;
    transition: all 0.4s ease-in-out;
  }

  #workspaces button label {
    color: ${base05};
    font-weight: bolder;
  }

  #workspaces button.empty {
    background: ${base02};
  }

  #workspaces button.active {
    background: radial-gradient(circle, ${base0C} 0%, ${base0E} 50%, ${base0D} 100%);
    background-size: 400% 400%;
    animation: gradient 5s linear infinite;
    transition: all 0.3s ease-in-out;
    border-color: ${base00};
  }

  #workspaces button.active label {
    color: ${base02};
    font-weight: bolder;
  }

  @keyframes gradient {
    0% { background-position: 0px 50px; }
    50% { background-position: 100px 30px; }
    100% { background-position: 0px 50px; }
  }

  /* modules */
  #custom-date,
  #battery,
  #backlight
  #clock,
  #pulseaudio,
  #workspaces,
  #window,
  #language,
  #text,
  #custom-launcher,
  #custom-separator

  #battery,
  #backlight,
  #custom-date,
  #cava,
  #network,
  #disk,
  #clock,
  #language,
  #pulseaudio,
  #custom-separator,
  #custom-launcher,
  #tray {
    color: ${base05};
    background-color: ${base00};
    padding: 0 0.4em;
    padding-top: 0px;
    padding-bottom: 2px;
    border-style: solid;
    min-height: 30px;
  }

  #workspaces {
    margin: 3 0 3 0px;
    border-radius: 14 14 14 14px;
  }
''
