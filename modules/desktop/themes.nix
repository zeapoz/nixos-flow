{
  flake.modules.homeManager.desktop = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      nwg-look # For theme previews.
    ];

    gtk = {
      enable = true;
      colorScheme = "dark";
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        package = pkgs.orchis-theme;
        name = "Orchis-Purple-Dark";
      };
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
