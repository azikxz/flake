{
  lib,
  ...
}:

let
  is = lib.x.sys.is;
in

# toml
''
  api_id = "25419489"
  api_hash = "81ae396dca8b973697fb9c5d3ad726bb"
  #
  database_dir = ".data/tg"
  use_file_database = true
  use_chat_info_database = true
  use_message_database = true
  system_language_code = "en"
  device_model = ${
    if is == "laptop" then
      "Laptop"
    else if is == "desktop" then
      "Desktop"
    else
      "Unknown"
  }
  verbosity_level = 2
  log_path = ".data/tdlib_rs/tdlib_rs.log"
  redirect_stderr = false
''
