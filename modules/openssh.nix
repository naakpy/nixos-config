{ ... }:
 {
  programs.ssh = {
  startAgent = true;  # Start SSH agent on boot
 };
 systemd.user.services.ssh-add = {
  description = "Add SSH key to agent on login";
  after = [ "ssh-agent.service" ];
  wantedBy = [ "default.target" ];
  serviceConfig.ExecStart = "/home/kaan/nixos-config/modules/custom/add-ssh.sh";
};


}
