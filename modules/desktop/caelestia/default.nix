{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages = {
      caelestia =
        inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli;

      toggle-idle-inhibitor = pkgs.writeShellApplication {
        name = "toggle-idle-inhibitor";
        runtimeInputs = [self'.packages.caelestia];
        text = builtins.readFile ./toggle-idle-inhibitor.sh;
      };
    };
  };

  flake.modules.nixos.desktop = {
    packages,
    pkgs,
    ...
  }: {
    environment.systemPackages = with packages; [
      caelestia
      toggle-idle-inhibitor
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."caelestia".source = config.meta.lib.mkConfigSymlink "caelestia";
  };
}
