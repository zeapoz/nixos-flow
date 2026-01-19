{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      nwg-look
      bibata-cursors
      orchis-theme
      papirus-icon-theme
    ];

    # Fix for some applications not picking up set xcursor, e.g. Steam.
    home.file.".local/share/icons/default" = {
      source = "${pkgs.bibata-cursors}/share/icons/Bibata-Original-Classic";
      recursive = true;
    };
  };
}
