{
  flake.modules.nixos.desktop = {pkgs, ...}: let
    retroarch = pkgs.retroarch.withCores (cores:
      with cores; [
        mesen
        gambatte
      ]);
  in {
    environment.systemPackages = with pkgs; [
      retroarch
      lutris
      wineWow64Packages.stable
      winetricks
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      gamescope = {
        enable = true;
        capSysNice = false;
      };
    };
  };
}
