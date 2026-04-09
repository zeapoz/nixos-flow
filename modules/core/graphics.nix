{
  flake.modules.nixos.core = {pkgs, ...}: {
    hardware.graphics.extraPackages = with pkgs; [libGL];

    environment.systemPackages = with pkgs; [vulkan-tools];
  };
}