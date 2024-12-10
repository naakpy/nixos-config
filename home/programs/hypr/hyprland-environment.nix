{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    };
  };
}
