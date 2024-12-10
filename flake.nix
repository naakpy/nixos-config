{
  description = "Unified NixOS configuration for multiple hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: let
    # Shared configuration for all hosts
    sharedConfig = {
      nixpkgs.config.allowUnfree = true;

      nix.settings.experimental-features = ["nix-command" "flakes"];
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };

      time.timeZone = "Europe/Paris";

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      services = {
        printing.enable = true;
        networking.networkmanager.enable = true;
        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
      };

      security.rtkit.enable = true;

      virtualisation = {
        virtualbox.host.enable = true;
        docker.rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      users.users.kaan = {
        isNormalUser = true;
        description = "Kaan";
        extraGroups = ["networkmanager" "wheel" "docker"];
        shell = inputs.nixpkgs.legacyPackages.x86_64-linux.zsh;
        ignoreShellProgramCheck = true;
      };

      # System packages
      environment.systemPackages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
        spotify-player wl-screenrec prismlauncher dbeaver-bin easyeffects thunderbird
        nano vesktop digikam jellyfin vim qbittorrent wget tor curl blender openssl
        git sysstat bash lm_sensors neofetch pavucontrol btop iotop iftop kitty
        rofi-wayland zsh unzip python3 appimage-run swww networkmanagerapplet mako
        jq brightnessctl hyprshot firefox superfile jellyfin-web
      ];

      # Fonts configuration
      fonts = {
        packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
          material-design-icons
          noto-fonts
          noto-fonts-emoji
          noto-fonts-cjk-sans
          font-awesome
          nerd-fonts.fira-code
          nerd-fonts.jetbrains-mono
        ];

        enableDefaultPackages = false;

        fontconfig.defaultFonts = {
          serif = ["Noto Serif" "Noto Color Emoji"];
          sansSerif = ["Noto Sans" "Noto Color Emoji"];
          monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    # Function to create host configurations
    makeHost = hostName: hostSpecific: inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/${hostName}/hardware-configuration.nix
        # Shared configurations
        {
          inherit (sharedConfig) config users services nixpkgs hardware boot virtualisation environment fonts;
        }
        # Host-specific configurations
        hostSpecific
      ];
    };

  in {
    nixosConfigurations = {
      # Define hosts
      nixos-pc = makeHost "nixos-pc" {
        networking.hostName = "nixos-pc";
      };

      nixos-laptop = makeHost "nixos-laptop" {
        networking.hostName = "nixos-laptop";
      };
    };
  };
}

