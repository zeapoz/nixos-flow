{
  inputs,
  config,
  ...
}: {
  flake.modules.nixos.core = {packages, ...}: {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "bk";

      extraSpecialArgs.packages = packages;

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
  };
}
