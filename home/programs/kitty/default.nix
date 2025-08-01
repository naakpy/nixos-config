{ config, pkgs, ... }:

{
  home.packages = [pkgs.kitty];
  home.file.".config/kitty/kitty.conf".text = ''
# vim:ft=kitty

#zshell
shell fish

# Remove bell
enable_audio_bell no

# Remove close window confirm
confirm_os_window_close 0

# Font config
font_family      jetbrains mono nerd font
bold_font        jetbrains mono nerd font
italic_font      jetbrains mono nerd font
bold_italic_font jetbrains mono nerd font

font_size 14.0

# Window padding
window_padding_width 10

# Catppuccin Theme
## name: Catppuccin
## author: Pocco81 (https://github.com/Pocco81)
## license: MIT
## upstream: https://raw.githubusercontent.com/catppuccin/kitty/main/catppuccin.conf
## blurb: Soothing pastel theme for the high-spirited!

# The basic colors
foreground              #E2E0EC
background              #0B0A10
selection_foreground    #D9E0EE
selection_background    #575268

# Transparent Background
background_opacity 0.8

# Cursor colors
cursor                  #F5E0DC
cursor_text_color       #1E1E2E

# URL underline color when hovering with mouse
url_color               #F5E0DC

# kitty window border colors
active_border_color     #C9CBFF
inactive_border_color   #575268
bell_border_color       #FAE3B0

# OS Window titlebar colors
wayland_titlebar_color system
macos_titlebar_color system

# Tab bar colors
active_tab_foreground   #F5C2E7
active_tab_background   #575268
inactive_tab_foreground #D9E0EE
inactive_tab_background #1E1E2E
tab_bar_background      #161320

# Colors for marks (marked text in the terminal)
mark1_foreground #1E1E2E
mark1_background #96CDFB
mark2_foreground #1E1E2E
mark2_background #F5C2E7
mark3_foreground #1E1E2E
mark3_background #B5E8E0

# The 16 terminal colors

# black
color0 #2B273F
color8 #61588E

# red
color1 #E97193
color9 #E97193

# green
color2  #AAC5A0
color10 #AAC5A0

# yellow
color3  #ECE0A8
color11 #ECE0A8

# blue
color4  #A8C5E6
color12 #A8C5E6

# magenta
color5  #DFA7E7
color13 #DFA7E7

# cyan
color6  #A8E5E6
color14 #A8E5E6

# white
color7  #E2E0EC
color15 #E2E0EC
  '';
}
