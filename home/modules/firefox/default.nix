{ pkgs, vars, config, ... }: let
  extensions = import ./extensions.nix;
  search_engines = import ./search-engines.nix;
  # bookmarks = import ./bookmarks.nix;
in {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
	ExtensionSettings = extensions;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off"; 
      SearchBar = "unified";
    };

    profiles.myprofile = {
      settings = {
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;
        "sidebar.verticalTabs" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.download.useDownloadDir" = false;
        "browser.toolbars.bookmarks.visibility" = true;
        "browser.translations.neverTranslateLanguages" = "sl";
        "devtools.toolbox.host" = "right";
	      # "browser.startup.homepage" = "https://home.${vars.net.domain}";
      };
      search = search_engines;
    };
  };
}
