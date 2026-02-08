{
  flake.modules.nixos.core = {
    nix.settings.experimental-features = ["nix-command" "flakes"];

    nixpkgs.config.allowUnfree = true;
  };
}
