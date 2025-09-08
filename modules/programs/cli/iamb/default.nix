{
  lib,
  ...
}:

with lib;
# INFO: tui matrix client
# https://servers.joinmatrix.org

mkIf (mac "thinkpadT14") {
  hm.programs.iamb = {
    enable = true;

    settings = {
      default_profile = "pub.solar";

      profiles =
        let
          mk = name: user_id: url: {
            inherit
              name
              ;
            value = {
              inherit
                user_id
                url
                ;
            };
          };
        in
        listToAttrs [
          (mk "pub.solar" "@xmozoid:pub.solar" "https://chat.pub.solar")
        ];

      settings = {
        notifications.enabled = true;

        image_preview.protocol = {
          type = "kitty";
          size = {
            height = 10;
            width = 66;
          };
        };

        layout = "new";
      };
    };
  };
}
