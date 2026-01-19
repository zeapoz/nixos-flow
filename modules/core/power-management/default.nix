{
  flake.modules.nixos.core = {pkgs, ...}: let
    next-power-profile = pkgs.writeShellApplication {
      name = "next-power-profile";
      runtimeInputs = [pkgs.libnotify];
      text = builtins.readFile ./next-power-profile.sh;
    };
  in {
    environment.systemPackages = [
      next-power-profile
    ];

    powerManagement.enable = true;

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
