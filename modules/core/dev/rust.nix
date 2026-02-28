{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rustup
    ];

    environment.variables.PATH = ["$HOME/.cargo/bin"];
  };
}
