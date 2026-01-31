{
  flake.modules.homeManager.desktop = {
    config,
    pkgs,
    ...
  }: let
    toggle-color-scheme = pkgs.writeShellApplication {
      name = "toggle-color-scheme";
      runtimeInputs = [pkgs.libnotify pkgs.dconf];
      text = builtins.readFile ./toggle-color-scheme.sh;
    };
  in {
    home.packages = with pkgs; [
      nwg-look # For theme previews.
      toggle-color-scheme
    ];

    gtk = {
      enable = true;
      colorScheme = "dark";
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
      theme = {
        package = pkgs.orchis-theme;
        name = "Orchis-Purple";
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
