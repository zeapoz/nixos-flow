{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.next-power-profile = pkgs.writeShellApplication {
      name = "next-power-profile";
      runtimeInputs = [self'.packages.caelestia];
      text = builtins.readFile ./next-power-profile.sh;
    };
  };

  flake.modules.nixos.core = {packages, ...}: {
    environment.systemPackages = with packages; [
      next-power-profile
    ];

    powerManagement.enable = true;

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
