{ pkgs, ... }: let
  pname = "cursor";
  
  # Define the name based on pname (and optionally version if you want)
  name = "${pname}";

  # Fetch the AppImage
  src = builtins.fetchurl {
    url = "https://downloader.cursor.sh/linux/appImage/x64";
    sha256 = "1h0ympyiwvyg02mq4w9kyw1k78rmh9y70b698ysa0i5kjhm4s4yc"; # This will be dynamically updated by the script
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname name src; };
in
  with pkgs;
  appimageTools.wrapType2 {
    inherit pname name src;
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-quiet 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${appimageContents}/usr/share/icons $out/share

      if [ -e ${appimageContents}/AppRun ]; then
        install -m 755 -D ${appimageContents}/AppRun $out/bin/${pname}
      else
        echo "Error: Binary not found in extracted AppImage contents."
        exit 1
      fi
    '';
    extraBwrapArgs = [
      "--bind-try /etc/nixos/ /etc/nixos/"
    ];
    dieWithParent = false;
    extraPkgs = pkgs: [
      unzip
      autoPatchelfHook
      asar
      (buildPackages.wrapGAppsHook.override { inherit (buildPackages) makeWrapper; })
    ];
  }

