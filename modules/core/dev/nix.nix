{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nil
      alejandra
      statix
    ];
  };
}
