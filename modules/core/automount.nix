{
  flake.modules.nixos.core = {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
