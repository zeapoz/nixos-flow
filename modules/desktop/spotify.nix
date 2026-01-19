{
  flake.modules.nixos.desktop = {pkgs, ...}: let
    spotify-wrapped = pkgs.symlinkJoin {
      name = "spotify-wrapped";
      paths = [pkgs.spotify];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    };
  in {
    environment.systemPackages = [
      spotify-wrapped
    ];
  };
}
