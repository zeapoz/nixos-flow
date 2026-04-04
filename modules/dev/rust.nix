{
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rustup
    ];

    environment.variables.PATH = ["$HOME/.cargo/bin"];
  };
}
