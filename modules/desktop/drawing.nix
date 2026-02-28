{
  flake.modules.nixos.desktop = {pkgs, ...}: let
    # Fix build failing for boost 1.89,
    # https://github.com/NixOS/nixpkgs/issues/485826
    boost = pkgs.boost187;
    krita = pkgs.krita-unwrapped.override {
      inherit boost;
      lager = pkgs.lager.override {
        inherit boost;
      };
    };
  in {
    environment.systemPackages = [
      krita
    ];
  };
}
