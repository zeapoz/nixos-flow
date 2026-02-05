{
  inputs,
  config,
  ...
}: let
  system = "x86_64-linux";
in {
  systems = [system];

  flake.nixosConfigurations = config.meta.lib.mkSystem {
    inherit system;
    name = "flow";
    stateVersion = "25.11";
    extraModules = [
      ./_hardware-configuration.nix

      # NOTE: Not the correct model, but tweaks should be pretty similiar.
      inputs.nixos-hardware.nixosModules.asus-flow-gv302x-amdgpu
    ];
  };
}
