{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.discord.override { withOpenASAR = true; })
    ];
  };
}