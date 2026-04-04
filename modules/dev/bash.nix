{
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bash-language-server
      shellcheck
      shfmt
    ];
  };
}
