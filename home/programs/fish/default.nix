{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      
      eval (ssh-agent -c) > /dev/null 2>&1
      ssh-add ~/.ssh/id_home > /dev/null 2>&1
    '';
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}
