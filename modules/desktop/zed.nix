{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zed-editor
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.configFile."zed".source = config.meta.lib.mkConfigSymlink "zed";
  };
}
