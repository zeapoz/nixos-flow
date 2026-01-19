{
  inputs,
  config,
  ...
}: {
  systems = ["x64_86-linux"];

  flake.nixosConfigurations = {
    flow = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.home-manager.nixosModules.home-manager

        inputs.self.modules.nixos.core
        inputs.self.modules.nixos.desktop

        # NOTE: Not the correct model, but tweaks should be pretty similiar.
        inputs.nixos-hardware.nixosModules.asus-flow-gv302x-amdgpu
        ./_hardware-configuration.nix # Include the results of the hardware scan.
        {
          networking.hostName = "flow";

          # This value determines the NixOS release from which the default
          # settings for stateful data, like file locations and database versions
          # on your system were taken. It‘s perfectly fine and recommended to leave
          # this value at the release version of the first install of this system.
          # Before changing this value read the documentation for this option
          # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
          system.stateVersion = "25.11"; # Did you read the comment?

          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "bk";

            users.${config.meta.username} = {
              imports = [
                inputs.self.modules.homeManager.core
                inputs.self.modules.homeManager.desktop

                ({osConfig, ...}: {
                  # The state version is required and should stay at the version you
                  # originally installed.
                  home.stateVersion = osConfig.system.stateVersion;
                })
              ];
            };
          };
        }
      ];
    };
  };
}
