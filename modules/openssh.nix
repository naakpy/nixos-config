{ config, pkgs, ... }:

let
  sshKeyPath = "/home/kaan/.ssh/id_rsa"; # Adjust to your key path
in
{
  # SSH agent service for user
  systemd.user.services.ssh-agent = {
    description = "SSH Agent";
    serviceConfig = {
      ExecStart = "${pkgs.openssh}/bin/ssh-agent -s";
      ExecStop = "${pkgs.openssh}/bin/ssh-agent -k";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  # Automatically load SSH key when the agent starts
  systemd.user.services."ssh-add-key" = {
    description = "Load SSH Key";
    serviceConfig = {
      ExecStart = "${pkgs.openssh}/bin/ssh-add ${sshKeyPath}";
      After = [ "ssh-agent.service" ];
    };
    wantedBy = [ "ssh-agent.service" ];
  };

  # Ensure the SSH_AUTH_SOCK environment is available to your shell
  environment.variables = {
    SSH_AUTH_SOCK = "${pkgs.openssh}/var/run/ssh-agent.socket";
  };
}

