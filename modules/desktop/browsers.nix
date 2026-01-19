{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      brave
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
