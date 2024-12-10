{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  material-design-icons
  noto-fonts
  noto-fonts-emoji
  noto-fonts-cjk-sans
  font-awesome
  nerdfonts
  ];
}

