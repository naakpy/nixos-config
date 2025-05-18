{ pkgs, gfxResolution ? "1920x1080", ... }: {
  boot = {

    plymouth = {
      enable = true;
      theme = "blahaj";
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader = {
      timeout = 0;
      grub = {
        gfxmodeEfi = gfxResolution;
        gfxmodeBios = gfxResolution;
      };
    };
  };
}