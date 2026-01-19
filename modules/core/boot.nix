{
  flake.modules.nixos.core = {pkgs, ...}: {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # Use latest zen kernel.
      kernelPackages = pkgs.linuxPackages_zen;
    };
  };
}
