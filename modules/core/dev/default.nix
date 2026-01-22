{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
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
