{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.toggle-color-scheme = pkgs.writeShellApplication {
      name = "toggle-color-scheme";
      runtimeInputs = [pkgs.dconf self'.packages.caelestia];
      text = builtins.readFile ./toggle-color-scheme.sh;
    };
  };

  flake.modules.homeManager.desktop = {
    config,
    packages,
    pkgs,
    ...
  }: {
    home.packages = with pkgs;
      [
        nwg-look # For theme previews.
      ]
      ++ [packages.toggle-color-scheme];

    gtk = {
      enable = true;
      colorScheme = "dark";
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
      theme = {
        package = pkgs.orchis-theme;
        name = "Orchis-Purple-Dark";
      };
      gtk4.theme = config.gtk.theme;
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 24;

      gtk.enable = true;
      hyprcursor.enable = true;
      x11 = {
        enable = true;
        defaultCursor = config.home.pointerCursor.name;
      };
    };
  };
}
