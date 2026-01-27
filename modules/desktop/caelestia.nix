{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."caelestia".source = config.meta.lib.mkConfigSymlink "caelestia";
  };
}
