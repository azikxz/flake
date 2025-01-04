{ x, ... }:
with x;
let
  repo = "https://github.com/axax-loll/fuji-wallpapers/blob/main";
in
{
  programs.floorp.profiles.${userName}.userContent =
    "	@-moz-document url(about:home), url(about:newtab), url(about:privatebrowsing) {\n		.click-target-container *, .top-sites-list * {\n			color: #fff !important ;\n			text-shadow: 2px 2px 2px #222 !important ;\n		}\n		body::before {\n			content: \"\" ;\n			z-index: -1 ;\n			position: fixed ;\n			top: 0 ;\n			left: 0 ;\n			background: #0F0F0F no-repeat url(\"${repo}/synth.png?raw=true\") center ;\n			background-size: cover ;\n			width: 100vw ;\n			height: 100vh ;\n		}\n		.logo { background-image: url(\"${repo}/logo.png?raw=true\") !important; }\n		.search-wrapper input { background: #0F0F0F !important; }\n		#PlacesToolbarItems {\n			width: 100%;\n			display: flex;\n			justify-content: center;\n		}\n	}\n";
}
