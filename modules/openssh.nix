{ ... }:
# In your configuration.nix
# In your configuration.nix
{
  # Other configurations...

  programs.ssh = {
    startAgent = true;  # Enable the SSH agent at boot
    knownHostsFile = "/home/kaan/.ssh/known_hosts";
    extraConfig = ''
      IdentityFile /home/kaan/.ssh/id_home  # Replace with your key path
    '';
  };

  # Other configurations...
}

