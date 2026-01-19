{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ghostty
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."ghostty".source = config.meta.lib.mkConfigSymlink "ghostty";
  };
}
