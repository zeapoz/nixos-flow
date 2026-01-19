{
  flake.modules.nixos.core = {pkgs, ...}: {
    hardware.graphics.extraPackages = [pkgs.libGL];
  };
}
