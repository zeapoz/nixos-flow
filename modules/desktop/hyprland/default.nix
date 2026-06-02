{config, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.touchpad-utils = pkgs.writeShellApplication {
      name = "touchpad-utils";
      runtimeInputs = [self'.packages.caelestia];
      text = builtins.readFile ./touchpad-utils.sh;
    };
  };

  flake.modules.nixos.desktop = {
    packages,
    pkgs,
    lib,
    ...
  }: {
    programs.hyprland.enable = true;

    # Prevent Hyprland from leaking CAP_SYS_NICE into ambient set (breaks bwrap)
    security.wrappers.Hyprland.capabilities = lib.mkForce "";

    environment.systemPackages = with pkgs;
      [
        brightnessctl
        hyprls
        nautilus
        libnotify
        playerctl
        wl-clipboard
      ]
      ++ [packages.touchpad-utils];

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/start-hyprland";
          user = config.meta.username;
        };
        default_session = initial_session;
      };
    };

    # Hint Electron apps to use Wayland.
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."hypr".source = config.meta.lib.mkConfigSymlink "hypr";
  };
}
