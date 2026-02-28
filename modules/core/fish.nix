{
  flake.modules.nixos.core = {pkgs, ...}: {
    programs = {
      fish.enable = true;
      starship.enable = true;
    };

    environment.systemPackages = with pkgs; [
      fishPlugins.fzf-fish
      fzf
    ];

    users.defaultUserShell = pkgs.fish;
  };

  flake.modules.homeManager.core = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    home.shell.enableFishIntegration = true;
  };
}
