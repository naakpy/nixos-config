{ inputs, pkgs, config, ... }:

{
  programs.librewolf = {
    enable = true;

    settings = {
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "network.cookie.lifetimePolicy" = 0;
      "privacy.resistFingerprinting" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
      # "layout.css.prefers-color-scheme.content-override" = 0;
      
      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.urlbar.placeholderName.private" = "DuckDuckGo";
      "browser.search.defaultenginename.US" = "DuckDuckGo";
      "browser.search.defaultenginename" = "DuckDuckGo";
      "browser.search.selectedEngine" = "DuckDuckGo";
      "browser.search.order.1" = "DuckDuckGo";
    };

    profiles.default = {
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
        ];
      };
    };
  };
}
