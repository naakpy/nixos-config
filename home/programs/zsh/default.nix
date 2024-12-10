{ config, pkgs, ... }:

{
    programs.zsh = {
      enable = true;
            oh-my-zsh = {
                enable = true;
                theme = "agnoster";
                plugins = [
                    "git"
                ];
            };
            autosuggestion.enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
        };
}
