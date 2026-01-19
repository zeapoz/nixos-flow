{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bash-language-server
      shellcheck
      shfmt
    ];
  };
}
