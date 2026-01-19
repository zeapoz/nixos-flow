{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gcc
      # Nix.
      nil
      alejandra
      statix
      # Rust.
      rustup
      # Markdown.
      marksman
      markdownlint-cli2
      prettier
      # Lua.
      lua-language-server
    ];
  };
}
