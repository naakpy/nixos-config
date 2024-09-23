services.openssh = {
  enable = true;
  agent = {
    enable = true;  # Enable the SSH agent
    identities = [ "~/.ssh/id_home" ];  # Replace with the path to your private SSH key
  };
};

