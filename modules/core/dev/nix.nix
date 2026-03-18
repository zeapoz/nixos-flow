{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nixd
      alejandra
      statix
    ];
  };
}
