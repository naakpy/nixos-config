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
      # Function to start ssh-agent
      function start_ssh_agent {
        echo "Starting ssh-agent..."
        eval "$(ssh-agent -s)" > /dev/null
        ssh-add /home/kaan/.ssh/id_home
      }

      # Check if SSH agent is running
      if [ -z "$SSH_AUTH_SOCK" ] || ! [ -S "$SSH_AUTH_SOCK" ]; then
        start_ssh_agent
      fi
  '';
 
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
    direnv = "eval $(direnv hook zsh)";
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
