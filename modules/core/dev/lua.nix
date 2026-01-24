{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      lua-language-server
    ];
  };
}
