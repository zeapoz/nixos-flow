{
  flake.modules.nixos.core = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      maple-mono.NF
      material-icons
    ];
  };
}
