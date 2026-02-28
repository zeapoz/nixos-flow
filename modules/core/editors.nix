{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gcc
      vim
      neovim
      tree-sitter
    ];

    environment.sessionVariables.EDITOR = "nvim";
  };
}
