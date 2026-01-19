{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
      neovim
      tree-sitter
    ];
  };
}
