{config, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: let
    touchpad-utils = pkgs.writeShellApplication {
      name = "touchpad-utils";
      runtimeInputs = [pkgs.libnotify];
      text = builtins.readFile ./touchpad-utils.sh;
    };
  in {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl
      hyprls
      nautilus
      libnotify
      touchpad-utils
      playerctl
      wl-clipboard
    ];

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
