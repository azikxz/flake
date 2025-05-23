{
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

# css
''
  * { font-family: "${config.stylix.fonts.sansSerif.name}" !important }

  .nBGzYhSIK1A7qANmTnpk { background-color: ${base01}; }
''
