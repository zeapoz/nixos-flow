{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      btop
      delta
      dust
      eza
      fd
      fzf
      ripgrep
      tldr
      wget
    ];

    programs = {
      bat.enable = true;
      zoxide.enable = true;

      fish.shellAliases = {
        cat = "bat";
        ls = "eza --icons=auto";
      };
    };
  };

  # Use delta in git diff.
  flake.modules.homeManager.core = {config, ...}: {
    programs.git.settings.core.pager = "delta";
  };
}
