{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "kaan";
    homeDirectory = "/home/kaan";
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  
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
    alias update="(cd ~/nixos-config && gwip && gp && git pull && nix flake update && sudo nixos-rebuild switch --flake .)"

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
}
