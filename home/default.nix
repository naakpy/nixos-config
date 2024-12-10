{ config, pkgs, ... }:

{
  home = {
    username = "kaan";
    homeDirectory = "/home/kaan";
    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    backgroundColor = "#151718";
    textColor = "#9FCA56";
    borderColor = "#151718";
  };

  programs.zsh = {
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;

  initExtra = ''
      function start_ssh_agent {
        eval "$(ssh-agent -s)" > /dev/null 2>&1
        ssh-add /home/kaan/.ssh/id_home > /dev/null 2>&1
      }

      start_ssh_agent
  '';

  shellAliases = {
    ll = "ls -l";
    direnv = "eval $(direnv hook zsh)";
    update = "(cd ~/nixos-config && gwip && gp && git pull && nix flake update && sudo nixos-rebuild switch --flake .)";

  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "robbyrussell";
  };
  };

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
}
