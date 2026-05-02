{
  withSystem,
  inputs,
  lib,
  ...
}: {
  options.meta = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The name of the user";
      default = "jonathan";
    };

    lib = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };
  };

  config.meta.lib.mkSystem = {
    name,
    system,
    stateVersion,
    extraModules,
  }: {
    ${name} = withSystem system ({config, ...}:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs.packages = config.packages;
        modules =
          [
            inputs.home-manager.nixosModules.home-manager
            inputs.handy.nixosModules.default

            inputs.self.modules.nixos.core
            inputs.self.modules.nixos.desktop
            inputs.self.modules.nixos.ai
            inputs.self.modules.nixos.dev

            {
              networking.hostName = name;
              system.stateVersion = stateVersion;
            }
          ]
          ++ extraModules;
      });
  };

  config.flake.modules.homeManager.core = {config, ...}: {
    options.meta = {
      nixosConfigDirectory = lib.mkOption {
        type = lib.types.path;
        apply = toString;
        description = "The path to the NixOS configuration directory";
        default = "${config.home.homeDirectory}/nixos";
      };

      nonNixConfigDirectory = lib.mkOption {
        type = lib.types.path;
        apply = toString;
        description = "The path to the directory storing non-nix configuration files";
        default = "${config.meta.nixosConfigDirectory}/config";
      };

      lib = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.unspecified;
        default = {};
      };
    };

    config.meta.lib.mkConfigSymlink = path:
      config.lib.file.mkOutOfStoreSymlink (config.meta.nonNixConfigDirectory + "/" + path);
  };
}
