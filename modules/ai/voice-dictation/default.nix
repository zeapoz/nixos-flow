{
  flake.modules.nixos.ai = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wtype
    ];

    programs.handy.enable = true;
  };
}
