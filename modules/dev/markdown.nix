{
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      marksman
      markdownlint-cli2
      prettier
    ];
  };
}
