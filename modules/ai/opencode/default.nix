{
  flake.modules.nixos.ai = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      opencode
      opencode-desktop
    ];

    networking.firewall.allowedTCPPorts = [4096];
  };
}
