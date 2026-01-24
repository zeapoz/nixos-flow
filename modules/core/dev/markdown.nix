{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      marksman
      markdownlint-cli2
      prettier
    ];
  };
}
