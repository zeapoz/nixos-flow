{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: let
    caelestia =
      inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli;

    toggle-idle-inhibitor = pkgs.writeShellApplication {
      name = "toggle-idle-inhibitor";
      runtimeInputs = [pkgs.libnotify caelestia];
      text = builtins.readFile ./toggle-idle-inhibitor.sh;
    };
  in {
    environment.systemPackages = [
      caelestia
      toggle-idle-inhibitor
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."caelestia".source = config.meta.lib.mkConfigSymlink "caelestia";
  };
}
