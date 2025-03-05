{
  programs.librewolf = {
    enable = true;
    settings = {
      # Don't forget Canva Blocker addon
      "webgl.disabled" = false;

      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.downloads" = false;

      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
