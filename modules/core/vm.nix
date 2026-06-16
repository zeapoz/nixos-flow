{config, ...}: {
  flake.modules.nixos.core = {
    virtualisation = {
      libvirtd = {
        enable = true;
        # Emable TPM support.
        qemu.swtpm.enable = true;
      };

      spiceUSBRedirection.enable = true;
    };

    users.groups = {
      libvirtd.members = [config.meta.username];
      kvm.members = [config.meta.username];
    };

    programs.virt-manager.enable = true;
  };
}
