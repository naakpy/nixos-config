{ config, pkgs, ... }:

{
  programs.fish = {
  enable = true;
  interactiveShellInit = ''
    set fish_greeting # Disable greeting
  '';
  plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}
