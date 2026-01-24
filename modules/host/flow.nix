{
  inputs,
  config,
  ...
}: {
  systems = ["x64_86-linux"];

  flake.nixosConfigurations = config.meta.lib.mkSystem {
    name = "flow";
    stateVersion = "25.11";
    extraModules = [
      ./_hardware-configuration.nix

      # NOTE: Not the correct model, but tweaks should be pretty similiar.
      inputs.nixos-hardware.nixosModules.asus-flow-gv302x-amdgpu
    ];
  };
}
