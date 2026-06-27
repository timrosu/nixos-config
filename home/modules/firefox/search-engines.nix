{
  force = true;
  default = "ddg";
  privateDefault = "ddg";
  order = [
    "ddg"
    "google"
    "fran"
    "youtube"
  ];
  engines = {
    # search engines
    #flandr = { # NOTE: not yet deployed
    #  urls = [{
    #    template = "https://search.${vars.net.domain}";
    #    params = [
    #    { name = "search"; value="{searchTerms}";}
    #    ];
    #  }];
    #  icon = "https://search.${vars.net.domain}/favicon.ico";
    #  updateInterval = 24 * 60 * 60 * 1000; # daily update
    #  definedAliases = [ "@s" ];
    #};
    fran = {
      name = "Fran";
      urls = [{
	template = "https://fran.si/iskanje";
	params = [
	{ name = "Query"; value = "{searchTerms}"; }
	];
      }];
      iconMapObj."16" = "https://fran.si/favicon.ico";
      definedAliases = [ "@fr" ];
    };
    youtube = {
      name = "Youtube";
      urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
      iconMapObj."16" = "https://www.youtube.com/favicon.ico";
      definedAliases = [ "@yt" ];
    };

    # nix resources
    nixos-wiki = {
      name = "NixOS Wiki";
      urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
      iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
      definedAliases = [ "@nixw" ];
    };
    nix-pagkages = {
      name = "Nix Packages";
      urls = [{
	template = "https://search.nixos.org/packages";
	params = [
	{ name = "type"; value = "packages"; }
	{ name = "query"; value = "{searchTerms}"; }
	];
      }];
      iconMapObj."96" = "https://search.nixos.org/favicon-96x96.png";
      definedAliases = [ "@nixp" ];
    };
    mynixos = {
      name = "MyNixOS";
      urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
      iconMapObj."16" = "https://mynixos.com/favicon.ico";
      definedAliases = [ "@nixm" ];
    };

    # shopping
    amazon-de = {
      name = "Amazon DE";
      urls = [{
	template = "https://www.amazon.de/s?k={searchTerms}";
      }];
      iconMapObj."48" = "https://www.amazon.de/favicon.ico";
      definedAliases = [ "@ad" ];
    };
    amazon-us = {
      name = "Amazon US";
      urls = [{
	template = "https://www.amazon.com/s?k={searchTerms}";
      }];
      iconMapObj."48" = "https://www.amazon.com/favicon.ico";
      definedAliases = [ "@a" ];
    };
    aliexpress = {
      name = "Aliexpress";
      urls = [{
	template = "https://www.aliexpress.com/w/wholesale-{searchTerms}.html";
      }];
      iconMapObj."16" = "https://www.aliexpress.com/favicon.ico";
      definedAliases = [ "@ali" ];
    };
  };
}
