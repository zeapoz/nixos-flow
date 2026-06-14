{
  flake.modules.nixos.core = {pkgs, ...}: {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelPackages = pkgs.linuxPackages_latest;

      kernelParams = [
        "amd_iommu=off"
        "amdgpu.gttsize=131072"
        "ttm.pages_limit=31457280"
      ];
    };
  };
}
