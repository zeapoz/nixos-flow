{lib, ...}: {
  options.meta.username = lib.mkOption {
    type = lib.types.str;
    description = "The name of the user";
    default = "jonathan";
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
