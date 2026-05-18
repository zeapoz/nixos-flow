{
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rustup
      cargo-watch
    ];

    environment.variables.PATH = ["$HOME/.cargo/bin"];
  };
}
